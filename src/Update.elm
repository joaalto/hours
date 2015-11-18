module Update where

import Date exposing (Date)
import Model exposing (..)

type Action
    = NoOp
    | Update
    | UpdateTime String
    | UpdateDate Date

update : Action -> Model -> Model
update action model =
    case action of
        Update -> model
        UpdateTime currentTime ->
            { model | time <- currentTime }
        UpdateDate currentDate ->
            { model | date <- Just currentDate }
