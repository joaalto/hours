module Update (..) where

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
  | SaveEntry (Maybe HourEntry)
  | EntrySaved (Result Http.Error (List String))


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    PreviousWeek ->
      ( { model
          | firstDayOfWeek =
              addDaysToDate -7 model.firstDayOfWeek
        }
      , Effects.none
      )

    NextWeek ->
      ( { model
          | firstDayOfWeek =
              addDaysToDate 7 model.firstDayOfWeek
        }
      , Effects.none
      )

    GetProjects query ->
      ( model, getProjects query )

    ProjectList projectsResult ->
      case projectsResult of
        Ok result ->
          ( { model | projects = result }, Effects.none )

        Err error ->
          ( { model | httpError = Err error }, Effects.none )

    SaveEntry newEntry ->
      let
        httpRequest =
          case entryExistsForDate model newEntry of
            False ->
              Api.postEntry

            True ->
              Api.patchEntry
      in
        case newEntry of
          Nothing ->
            ( model, Effects.none )

          Just entry ->
            ( addEntryToModel entry model, saveEntry httpRequest newEntry )

    EntrySaved hourEntry ->
      case hourEntry of
        Ok entry ->
          ( model, Effects.none )

        Err error ->
          ( { model | httpError = Err error }, Effects.none )


getProjects : String -> Effects Action
getProjects query =
  Api.getProjects query
    |> Task.toResult
    |> Task.map ProjectList
    |> Effects.task


entryExistsForDate : Model -> Maybe HourEntry -> Bool
entryExistsForDate model newEntry =
  case newEntry of
    Nothing ->
      False

    Just entry ->
      List.any
        (\project ->
          List.any
            (\e ->
              sameDate e.date entry.date && e.projectId == entry.projectId
            )
            project.hourEntries
        )
        model.projects


saveEntry : (HourEntry -> Task Http.Error (List String)) -> Maybe HourEntry -> Effects Action
saveEntry httpRequest hourEntry =
  case hourEntry of
    Nothing ->
      Effects.none

    Just entry ->
      httpRequest entry
        |> Task.toResult
        |> Task.map EntrySaved
        |> Effects.task


addEntryToModel : HourEntry -> Model -> Model
addEntryToModel entry model =
  { model
    | projects =
        List.map
          (\project ->
            { project
              | hourEntries =
                  if (project.id == entry.projectId) then
                    entry :: project.hourEntries
                  else
                    project.hourEntries
            }
          )
          model.projects
  }
