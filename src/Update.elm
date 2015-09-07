module Update where

import Model exposing (..)

type Action = Update

update : Action -> Model -> Model
update action model =
    case action of
        Update -> model


