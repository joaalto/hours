module View where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Signal, Address)
import Time exposing (Time, every, second)
import Date exposing (year, hour, minute, second, fromTime)
import Graphics.Element exposing (Element, show)
import Task exposing (Task)

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

