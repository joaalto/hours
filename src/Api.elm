module Api where

import Http exposing (Error)
import Json.Decode as Json exposing (..)
import Json.Encode as Encode exposing (encode)
import Task exposing (Task)
import Date exposing (Date)
import String

import DateUtils exposing (fullDate)
import Model exposing (Project, HourEntry, NewHourEntry)

type alias RequestParams =
    { verb : String
    , url : String
    }

getProjects : String -> Task Error (List Project)
getProjects query =
    Http.get decodeProjects "/project?select=id,name,hour_entry{*}"

decodeProjects : Json.Decoder (List Project)
decodeProjects =
    list
        (object3 Project
            ("id"   := int)
            ("name" := string)
            ("hour_entry" := list decodeHourEntry))

decodeHourEntry : Json.Decoder HourEntry
decodeHourEntry =
    (object4 HourEntry
        ("id"       := int)
        ("project_id" := int)
        ("date"     := Json.customDecoder string Date.fromString)
        ("hours"    := float))

postEntry : NewHourEntry -> Task Error HourEntry
postEntry hourEntry =
    doUpdate
        { verb = "POST"
        , url = "/hour_entry"
        }
        hourEntry

patchEntry : NewHourEntry -> Task Error HourEntry
patchEntry hourEntry =
    doUpdate
        { verb = "PATCH"
        , url = String.concat
            [ "/hour_entry?date=eq."
            , fullDate hourEntry.date
            , "&project_id=eq."
            , toString hourEntry.projectId
            ]
        }
        hourEntry

doUpdate : RequestParams -> NewHourEntry -> Task Error HourEntry
doUpdate request hourEntry =
    Http.fromJson
        (decodeHourEntry)
        (Http.send Http.defaultSettings
            { verb = request.verb
            , headers =
                [ ("Content-type", "application/json")
                , ("Prefer", "return=representation")
                ]
            , url = request.url
            , body = (encodeEntry >> encode 4 >> Http.string) hourEntry
            })

encodeEntry : NewHourEntry -> Encode.Value
encodeEntry hourEntry =
    Encode.object
        [ ("project_id", Encode.int hourEntry.projectId)
        , ("date",  Encode.string (fullDate hourEntry.date))
        , ("hours", Encode.float hourEntry.hours)
        ]
