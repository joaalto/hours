module View where

import Html exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (Address)
import Maybe exposing (withDefault)
import Date exposing (year, month, day)

import Model exposing (..)
import Update exposing (Action)
import DateUtils exposing (..)

view : Address Action -> Model -> Html
view address model =
    div
      [ class "main"]
      [ text model.time
      , table []
        [ thead []
          (th [][] ::
           List.map (\day ->
              th [] [ text ((snd day) ++ " " ++ toString
                  (dayIndexToDateString (fst day) model.currentDate))])
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
