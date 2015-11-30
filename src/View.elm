module View where

import Html exposing (..)
import Html.Attributes exposing (..)
import Signal exposing (Address)
import Maybe exposing (withDefault)

import Model exposing (..)
import Update exposing (Action)
import DateUtils exposing (..)

view : Address Action -> Model -> Html
view address model =
    div
      [ myStyle ]
      [ text model.time
      , table []
        [ thead []
          (th [][] ::
           List.map (\day ->
              th [] [ text ((snd day) ++ " " ++
                  (dayIndexToDateString (fst day) model.currentDate))])
              weekDays)
        , tbody []
            (List.map projectRow model.projects)
        ]
      ]

myStyle : Attribute
myStyle =
    style
        [ ("fontFamily", "sans-serif") ]

inputStyle : Attribute
inputStyle =
    style
        [ ("borderRadius", "4px")
        , ("textAlign", "right")
        , ("borderStyle", "solid")
        , ("borderColor", "grey")
        , ("width", "8em")
        ]

projectRow : Project -> Html
projectRow project =
    tr
      []
      (td [] [text project.name] ::
       List.map (\dayOfWeek ->
          td [] [input [inputStyle, value (projectEntry dayOfWeek project)] []])
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
