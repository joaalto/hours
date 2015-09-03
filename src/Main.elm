import Html exposing (div, input, button, text, Html)
import Html.Events exposing (onClick)
import StartApp.Simple as StartApp
import Signal exposing (Signal, Address)

--module Main where

-- MODEL

type alias Model =
    { projects : List Project
    }

type alias Project =
    { id : Int
    , name : String
}

emptyModel : Model
emptyModel = 
    { projects = []
    }

-- UPDATE

type Action = Reset

update : Action -> Model -> Model
update action model =
  case action of
    Reset -> model

-- VIEW

view : Address Action -> Model -> Html
view address model =
    div []
        [ 
          input [] []
        , button [] [ text "jep"]
        ]

main =
    StartApp.start
    { model = emptyModel 
    , update = update
    , view = view }
