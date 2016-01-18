module Api where

import Http exposing (Error)
import Json.Decode as Json exposing (..)
import Json.Encode as Encode exposing (encode)
import Task exposing (Task)
import Date exposing (Date)
import Date.Format exposing (format)

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
            ("hour_entry" := decodeHourEntries))

decodeHourEntries : Json.Decoder (List HourEntry)
decodeHourEntries =
    list
        (object3 HourEntry
            ("id"       := int)
            ("date"     := Json.customDecoder string Date.fromString)
            ("hours"    := float))

postEntry : NewHourEntry -> Task Error (List String)
postEntry hourEntry =
    let encodedEntry =
        Encode.object
            [ ("project_id", Encode.int hourEntry.projectId)
            , ("date",  Encode.string (Debug.log "date" (format "%Y-%m-%d" hourEntry.date)))
            , ("hours", Encode.float hourEntry.hours)
            ]
    in
        Http.post (list string) "/hour_entry" (Http.string (encode 4 encodedEntry))
