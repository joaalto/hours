import Html exposing (div, input, button, text, Html)
import Html.Events exposing (onClick)
import StartApp.Simple as StartApp
import Signal exposing (Signal, Address)

--module Main where

-- MODEL

type alias Model = { }

-- UPDATE

type Action = Reset

update : Action -> Model -> Model
update action model =
  case action of
    Reset -> model

-- VIEW

--view : Address Action -> Model -> Html

view address model =
    div []
        [ 
          input [] []
        , button [] [ text "jep"]
        ]

main =
    StartApp.start
    { model = {}
    , update = update
    , view = view }
