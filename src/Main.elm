module Main where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
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
            , hourEntries = [
                { date = 123
                , hours = 7.5
                }]
            },
            { id = 2
            , name = "Toka projekti"
            , hourEntries = []
        }
        ]
    }

weekDays = [ "Ma", "Ti", "Ke", "To", "Pe", "La", "Su" ]

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
      [ table []
        [ thead []
          (th [][] ::
           List.map (\d ->
              th [] [ text d ])
              weekDays)
        , tbody []
            (List.map projectRow model.projects)
        ]
      ]

projectRow : Project -> Html
projectRow project =
    tr
      []
      (td [] [text project.name] ::
       List.map (\e ->
          td [] [input [value (toString e.hours)] []])
          project.hourEntries)

main =
    StartApp.start
    { model = mockData
    , update = update
    , view = view }

