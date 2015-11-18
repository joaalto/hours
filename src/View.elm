module View where

import Html exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (Address)
import Date exposing (..)

import Model exposing (..)
import Update exposing (Action)

view : Address Action -> Model -> Html
view address model =
    div
      [ class "main"]
      [ text model.time
      , table []
        [ thead []
          (th [][] ::
           List.map (\d ->
              th [] [ text d ])
              weekDays)
        , tbody []
            (List.map projectRow model.projects)
        ]
      ]

-- weekDates : Date -> List Day
-- weekDates date =


projectRow : Project -> Html
projectRow project =
    tr
      []
      (td [] [text project.name] ::
       List.map (\dayOfWeek ->
          td [] [input [value (projectEntry dayOfWeek project)] []])
          [0..6])

projectEntry : Int -> Project -> String
projectEntry dayOfWeek project =
    let projectEntry = project.hourEntries
        |> List.filter (\e -> e.dayOfWeek == dayOfWeek)
        |> List.head
    in
        case projectEntry of
            Nothing -> ""
            Just entry -> toString entry.hours
