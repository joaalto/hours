module Api where

import Http exposing (Error)
import Json.Decode as Json exposing (..)
import Task exposing (..)

--import Model exposing (Project, HourEntry)

projects : Task Error (List (Int, String))
projects =
    Http.get decodeProjects "http:localhost:3000/project"

decodeProjects : Json.Decoder (List (Int, String))
decodeProjects =
    list (object2 (,)
        ("id"   := int)
        ("name" := string))
