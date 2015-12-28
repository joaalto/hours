module Update where

import Date exposing (Date)
import Model exposing (..)
import DateUtils exposing (addDaysToDate)
import Api

type Action
    = NoOp
    | Update
    | UpdateTime String
    | UpdateDate Date
    | PreviousWeek
    | NextWeek
    | GetProjects

update : Action -> Model -> Model
update action model =
    case action of
        Update -> model
        UpdateTime currentTime ->
            { model | time = currentTime }
        UpdateDate currentDate ->
            { model | currentDate = currentDate }
        PreviousWeek ->
            { model | firstDayOfWeek =
                addDaysToDate -7 model.firstDayOfWeek }
        NextWeek ->
            { model | firstDayOfWeek =
                addDaysToDate 7 model.firstDayOfWeek }
        NoOp -> model
        GetProjects ->
            model
            -- { model | projects =
                -- Api.projects }
