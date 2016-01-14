module Api where

import Http exposing (Error, Response, RawError, send, fromJson, defaultSettings, empty)
import Json.Decode as Json exposing (..)
import Task exposing (Task, andThen)
import Date exposing (Date)

import Model exposing (Project, HourEntry)

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
