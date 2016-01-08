module Api where

import Http exposing (Error)
import Json.Decode as Json exposing (..)
import Task exposing (Task, andThen)
import Date exposing (Date)

import Model exposing (Project, HourEntry)

-- "localhost:3000/project?id=eq.1&select=*,hour_entry{*}"
getProjects : String -> Task Error (List Project)
getProjects query =
    Http.get decodeProjects "localhost:3000/project?select=*,hour_entry{*}"

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
        (object4 HourEntry
            ("id"       := int)
            ("dayOfWeek":= int)
            ("date"     := Json.customDecoder string Date.fromString)
            ("hours"    := float))
