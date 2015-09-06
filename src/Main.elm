module Main where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import StartApp.Simple as StartApp
import Signal exposing (Signal, Address)
import Date
import Array

-- MODEL

type alias Model =
    { projects : List Project
    }

type alias Project =
    { id : Int
    , name : String
    , hourEntries : List HourEntry
    --, hourEntries : List HourEntry
    }

type alias HourEntry =
    { dayOfWeek : Int
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
            , hourEntries =
                [ { dayOfWeek = 0
                  , hours = 7.5
                  }
                , { dayOfWeek = 3
                  , hours = 7.5
                  }
                ]
            },
            { id = 2
            , name = "Toka projekti"
            , hourEntries =
                [ { dayOfWeek = 4
                  , hours = 3.5
                  }
                ]
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
       List.map (\dayOfWeek ->
          td [] [input [value (entryHours (projectEntry dayOfWeek project))] []])
          [0..6])

entryHours : Maybe HourEntry -> String
entryHours projectEntry =
    case projectEntry of
        Nothing -> ""
        Just entry -> toString entry.hours

projectEntry : Int -> Project -> Maybe HourEntry
projectEntry dayOfWeek project =
    project.hourEntries
    |> List.filter (\e -> e.dayOfWeek == dayOfWeek)
    |> List.head

main =
    StartApp.start
    { model = mockData
    , update = update
    , view = view }

