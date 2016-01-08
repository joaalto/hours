module View where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Address)
import Maybe exposing (withDefault)
import Effects exposing (Effects)

import Model exposing (..)
import Update exposing (..)
import DateUtils exposing (..)
import Style

--view : Address Action -> (Model, Effects Action) -> Html
view : Address Action -> Model -> Html
view address model =
    div [ Style.body ]
        [ navigationPane address model
        , table []
            [ thead []
                [ dayHeader model ]
            , tbody []
                (List.map projectRow model.projects)
            ]
        ]

dayHeader : Model -> Html
dayHeader model =
    tr []
        (th [][] ::
           List.map (\day ->
              th [] [ text ((snd day) ++ " " ++
                  (dayIndexToDateString (fst day) model.firstDayOfWeek))])
              weekDays)

navigationPane : Address Action -> Model -> Html
navigationPane address model =
    div []
        [ div
            [ Style.timer ]
            [ text model.time ]
        , div
            [ Style.navigation ]
            [ button
                [ onClick address PreviousWeek ]
                [ text "< Edellinen viikko" ]]
        , div
            [ Style.bold ]
            [ button
                [ onClick address NextWeek ]
                [ text "Seuraava viikko >" ]]
        ]

projectRow : Project -> Html
projectRow project =
    tr []
      (td [ style [("width", "180px")]]
        [text project.name] ::
            List.map (\dayOfWeek ->
                td [] [input [ Style.input, value (projectEntry dayOfWeek project)] []])
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
