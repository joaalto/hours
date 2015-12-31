module Main where

import Model exposing (..)
import Update exposing (Action, update)
import View exposing (view)
import DateUtils exposing (..)
import Api exposing (..)

import Time exposing (Time, every)
import Date exposing (Date, hour, minute, second, fromTime)
import Signal exposing (Signal, Mailbox, Address, send)
import Html exposing (..)
import String exposing (padLeft)
import Result exposing (..)
import Task exposing (Task)
import Http exposing (Error)

port startTime : Time

main : Signal Html
main =
    Signal.map (view actions.address) modelSignal

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

-- manage the model of our application over time
modelSignal : Signal Model
modelSignal =
    Signal.foldp
        update
        initialModel
        (Signal.merge actions.signal timeSignal)

actions : Mailbox Action
actions =
    Signal.mailbox Update.GetProjects

port requests : Signal (Task Error (List Project))
-- port requests : Signal (Result a b)
port requests =
    Signal.map Api.getProjects queries.signal
    -- queries.signal
    --     |> Api.getProjects
        -- |> Signal.map (\task -> task `andThen` Signal.send results.address)

queries : Mailbox String
queries =
    Signal.mailbox ""

results : Mailbox (Result String (List Project))
-- results : Mailbox (Task String (List Project))
results =
    Signal.mailbox (Err "")


initialModel : Model
initialModel =
    { time = ""
    , currentDate = Date.fromTime startTime
    , firstDayOfWeek = dayIndexToDate 0 (Date.fromTime startTime)
    , projects = []
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
    }
