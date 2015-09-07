module View where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Signal, Address)

import Model exposing (..)
import Update exposing (Action)

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

