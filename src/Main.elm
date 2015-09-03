module Main where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import StartApp.Simple as StartApp
import Signal exposing (Signal, Address)


-- MODEL

type alias Model =
    { projects : List Project
    }

type alias Project =
    { id : Int
    , name : String
    , hourEntries : List HourEntry
    }

type alias HourEntry =
    { date : Int
    , hours : Float
    }

emptyModel : Model
emptyModel =
    { projects = []
    }

mockData : Model
mockData =
    { projects =
        [
            { id = 1
            , name = "Eka projekti"
            , hourEntries = []
            },
            { id = 2
            , name = "Toka projekti"
            , hourEntries = []
        }
        ]
    }

-- UPDATE

type Action = Update

update : Action -> Model -> Model
update action model =
    case action of
        Update -> model

-- VIEW

view : Address Action -> Model -> Html
view address model =
    div
      [ class "main"]
      [
        input [] []
      , button [] [ text "jep"]
      , ul
        [ id "project-list" ]
        (List.map projectName model.projects)
      ]

projectName : Project -> Html
projectName project =
    li
      []
      [ text project.name ]

main =
    StartApp.start
    { model = mockData
    , update = update
    , view = view }

