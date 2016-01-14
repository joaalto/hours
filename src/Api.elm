module Api where

import Http exposing (Error, Response, RawError, send, fromJson, defaultSettings, empty)
import Json.Decode as Json exposing (..)
import Task exposing (Task, andThen)
import Date exposing (Date)

import Model exposing (Project, HourEntry)

-- "localhost:3000/project?id=eq.1&select=*,hour_entry{*}"
getProjects : String -> Task Error (List Project)
getProjects query =
    get decodeProjects "/project?select=id,name,hour_entry{*}"

get : Json.Decoder (List Project) -> String -> Task Error (List Project)
get decoder url =
    fromJson decodeProjects (crossOriginGet url)

crossOriginGet : String -> Task RawError Response
crossOriginGet url =
    send defaultSettings
        { verb = "GET"
        , headers = []
        , url = url
        , body = empty
        }

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
