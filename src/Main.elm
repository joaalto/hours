module Main where

import Model exposing (..)
import Update exposing (Action, update)
import View exposing (view)
import DateUtils exposing (..)

import StartApp
import Time exposing (Time, every)
import Date exposing (Date, hour, minute, second, fromTime)
import Signal exposing (Signal, Mailbox, Address, send)
import Html exposing (..)
import Task
import Effects exposing (Effects, Never)

port startTime : Time

app : StartApp.App Model
app =
    StartApp.start
        { init = init ""
        , update = update
        , view = view
        , inputs = []
        }

main : Signal Html
main =
    app.html

port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks

init : String -> (Model, Effects Action)
init query =
    ( initialModel
    , Update.getProjects query
    )

initialModel : Model
initialModel =
    { time = ""
    , currentDate = Date.fromTime startTime
    , firstDayOfWeek = dayIndexToDate 0 (Date.fromTime startTime)
    , projects = Ok []
    , httpError = Ok ()
    }
