module Update where

import Model exposing (..)

type Action
    = Update
    | UpdateTime String

update : Action -> Model -> Model
update action model =
    case action of
        Update -> model
        UpdateTime currentTime ->
            { model | time <- currentTime }


