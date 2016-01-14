module Main where

import Model exposing (..)
import Update exposing (Action, update)
import View exposing (view)
import DateUtils exposing (..)
import Api exposing (..)

import StartApp
import Time exposing (Time, every)
import Date exposing (Date, hour, minute, second, fromTime)
import Signal exposing (Signal, Mailbox, Address, send)
import Html exposing (..)
import String exposing (padLeft)
-- import Result exposing (Result)
import Task exposing (Task, toResult, andThen)
import Http exposing (Error)
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
    -- Signal.map (view actions.address) modelSignal

main : Signal Html
main =
    app.html

port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks

currentTime : Time -> String
currentTime t =
    let date' = fromTime t
        hour' = pad (hour date')
        minute' = pad (minute date')
        second' = pad (second date')
    in
        hour' ++ ":" ++ minute' ++ ":" ++ second'

pad : Int -> String
pad = padLeft 2 '0' << toString

timeSignal : Signal Action
timeSignal =
    every Time.second
    |> Signal.map currentTime
    |> Signal.map Update.UpdateTime

init : String -> (Model, Effects Action)
init query =
    ( initialModel
    , Update.getProjects query
    )

actions : Mailbox Action
actions =
    Signal.mailbox (Update.GetProjects "")

queries : Mailbox String
queries =
    Signal.mailbox ""

results : Mailbox (Result Error (List Project))
results =
    Signal.mailbox (Ok [])

-- port requests : Signal (Task Error ())
-- port requests =
--     Signal.map Api.getProjects queries.signal
--         |> Signal.map (\task -> Task.toResult task `andThen` Signal.send results.address)

-- initialModel : (Model, Effects Action)
initialModel : Model
initialModel =
    { time = ""
    , currentDate = Date.fromTime startTime
    , firstDayOfWeek = dayIndexToDate 0 (Date.fromTime startTime)
    , projects = (Ok [])
    }
        -- Api.projects
        -- [
        --     { id = 1
        --     , name = "Eka projekti"
        --     , hourEntries = []
        --         -- [ { date =
        --         --   , hours = 7.5
        --         --   }
        --         -- , { dayOfWeek = 3
        --         --   , hours = 7.5
        --         --   }
        --         -- ]
        --     },
        --     { id = 2
        --     , name = "Toka projekti"
        --     , hourEntries = []
        --         -- [ { dayOfWeek = 4
        --         --   , hours = 3.5
        --         --   }
        --         -- ]
        --     }
        -- ]
    -- }
