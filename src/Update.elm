module Update where

import Http
import Task exposing (Task)
import Effects exposing (Effects)
import Model exposing (..)
import DateUtils exposing (addDaysToDate)
import Api exposing (..)

type Action
    = NoOp
    | PreviousWeek
    | NextWeek
    | GetProjects String
    | ProjectList (Result Http.Error (List Project))
    | SaveEntry (Maybe NewHourEntry)

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        NoOp ->
            (model, Effects.none)
        PreviousWeek ->
            ({ model | firstDayOfWeek =
                addDaysToDate -7 model.firstDayOfWeek }, Effects.none)
        NextWeek ->
            ({ model | firstDayOfWeek =
                addDaysToDate 7 model.firstDayOfWeek }, Effects.none)
        GetProjects query ->
            (model, getProjects query)
        ProjectList projectsResult ->
            ({ model | projects = projectsResult }
            , Effects.none)
        SaveEntry newEntry ->
            (model, saveEntry newEntry)

getProjects : String -> Effects Action
getProjects query =
    Api.getProjects query
        |> Task.toResult
        |> Task.map ProjectList
        |> Effects.task

saveEntry : Maybe NewHourEntry -> Effects Action
saveEntry hourEntry =
    case (Debug.log "hourEntry" hourEntry) of
        Nothing -> Effects.none
        Just entry -> Effects.none
