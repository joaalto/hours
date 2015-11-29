module Update where

import Date exposing (Date)
import Model exposing (..)

import Debug

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
            -- (Debug.log "currentTimex" (toString currentTime))
            { model | time = currentTime }
        UpdateDate currentDate ->
            -- Debug.log ("currentDatex" ++ toString currentDate)
            { model | currentDate = Just currentDate }
        NoOp -> model
