module View where

import Date exposing (Date)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Address)
import Maybe

import Model exposing (..)
import Update exposing (..)
import DateUtils exposing (..)
import Style

--view : Address Action -> (Model, Effects Action) -> Html
view : Address Action -> Model -> Html
view address model =
    case model.projects of
        Err msg ->
            div
                [ style [ ("color", "red" ) ]]
                [ text (toString msg) ]
        Ok projects ->
            div
                [ Style.body ]
                [ navigationPane address model
                , table []
                    [ thead []
                        [ dayHeader model ]
                    , tbody []
                        (List.map (projectRow address model.firstDayOfWeek) projects)
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

projectRow : Address Action -> Date -> Project -> Html
projectRow address firstDayOfWeek project =
    tr []
      (td [ style [("width", "180px")]]
        [text project.name] ::
            List.map (\dayIndex ->
                let entry = (hourEntry dayIndex firstDayOfWeek project)
                in
                    td []
                        [ input
                            [ Style.input
                            , value (hours entry)
                            , onClick address (SaveEntry entry)
                            ] []])
                    [0..6])

hours : Maybe HourEntry -> String
hours hourEntry =
    case hourEntry of
        Nothing -> ""
        Just e -> toString e.hours

hourEntry : Int -> Date -> Project -> Maybe HourEntry
hourEntry dayIndex firstDayOfWeek project =
    project.hourEntries
        |> List.filter (\entry ->
            formatDate entry.date == formatDate (dayIndexToDate dayIndex firstDayOfWeek))
        |> List.head
