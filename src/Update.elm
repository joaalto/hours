module Update where

import Http
import Date exposing (Date)
import Task exposing (Task)
import Effects exposing (Effects)
import Model exposing (..)
import DateUtils exposing (addDaysToDate)
import Api exposing (..)

type Action
    = NoOp
    | Update
    | UpdateTime String
    | UpdateDate Date
    | PreviousWeek
    | NextWeek
    | GetProjects String
    | ProjectList (Result Http.Error (List Project))
    -- | ProjectList (Maybe (List Project))

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        Update -> (model, Effects.none)
        UpdateTime currentTime ->
            ({ model | time = currentTime }, Effects.none)
        UpdateDate currentDate ->
            ({ model | currentDate = currentDate }, Effects.none)
        PreviousWeek ->
            ({ model | firstDayOfWeek =
                addDaysToDate -7 model.firstDayOfWeek }, Effects.none)
        NextWeek ->
            ({ model | firstDayOfWeek =
                addDaysToDate 7 model.firstDayOfWeek }, Effects.none)
        NoOp ->
            (model, Effects.none)
        GetProjects query ->
            (model, getProjects query)
        ProjectList projectsResult ->
            ({ model | projects = projectsResult }
            , Effects.none)

getProjects : String -> Effects Action
getProjects query =
    Api.getProjects query
        |> Task.toResult
        |> Task.map ProjectList
        |> Effects.task
