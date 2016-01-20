module Update where

import Http
import Task exposing (Task)
import Effects exposing (Effects)
import Model exposing (..)
import DateUtils exposing (addDaysToDate, sameDate)
import Api exposing (..)

type Action
    = NoOp
    | PreviousWeek
    | NextWeek
    | GetProjects String
    | ProjectList (Result Http.Error (List Project))
    | SaveEntry (Maybe NewHourEntry)
    | EntrySaved (Result Http.Error HourEntry)

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
            let updateFunction =
            case entryExistsForDate model newEntry of
                False -> Api.postEntry
                True -> Api.patchEntry
            in
                (model, saveEntry updateFunction newEntry)
        EntrySaved hourEntry ->
            case hourEntry of
                Err msg -> (model, Effects.none)
                Ok entry -> (addEntryToModel entry model, Effects.none)

getProjects : String -> Effects Action
getProjects query =
    Api.getProjects query
        |> Task.toResult
        |> Task.map ProjectList
        |> Effects.task

entryExistsForDate : Model -> Maybe NewHourEntry -> Bool
entryExistsForDate model newEntry =
    case newEntry of
        Nothing -> False
        Just entry ->
            let projects = Result.withDefault [] model.projects
            in
                List.length
                    (List.filter (\project ->
                        List.any (\e -> sameDate e.date entry.date)
                        project.hourEntries)
                    projects) > 0

saveEntry : (NewHourEntry -> Task Http.Error HourEntry) -> Maybe NewHourEntry -> Effects Action
saveEntry updateFunction hourEntry =
    case hourEntry of
        Nothing -> Effects.none
        Just entry ->
            updateFunction entry
                |> Task.toResult
                |> Task.map EntrySaved
                |> Effects.task

addEntryToModel : HourEntry -> Model -> Model
addEntryToModel entry model =
    { model | projects =
        Result.map (\projectResult ->
            List.map (\project ->
                { project | hourEntries =
                    if (project.id == entry.projectId) then
                        entry :: project.hourEntries
                    else
                        project.hourEntries })
            projectResult)
        model.projects }
