module Api where

import Http exposing (Error)
import Json.Decode as Json exposing (..)
import Json.Encode as Encode exposing (encode)
import Task exposing (Task)
import Date exposing (Date)

import DateUtils exposing (fullDate)
import Model exposing (Project, HourEntry, NewHourEntry)

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
    let encodedEntry =
        Encode.object
            [ ("project_id", Encode.int hourEntry.projectId)
            , ("date",  Encode.string (fullDate hourEntry.date))
            , ("hours", Encode.float hourEntry.hours)
            ]
    in
        Http.fromJson
            (decodeHourEntry)
            (Http.send Http.defaultSettings
                { verb = "POST"
                , headers =
                    [ ("Content-type", "application/json")
                    , ("Prefer", "return=representation")
                    ]
                , url = "/hour_entry"
                , body = (Http.string (encode 4 encodedEntry))
                })
