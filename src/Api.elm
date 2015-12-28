module Api where

import Http exposing (Error)
import Json.Decode as Json exposing (..)
import Task exposing (..)
import Date exposing (Date)

import Model exposing (Project, HourEntry)

-- "localhost:3000/project?id=eq.1&select=*, hour_entry{*}"
projects : Task Error (List Project)
projects =
    Http.get decodeProjects "http:localhost:3000/project"

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
