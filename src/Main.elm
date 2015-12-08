module Main where

import Model exposing (..)
import Update exposing (Action, update)
import View exposing (view)
import DateUtils exposing (..)

import Time exposing (Time, every)
import Date exposing (Date, hour, minute, second, fromTime)
import Signal exposing (Signal, Mailbox, Address, send)
import Html exposing (..)
import String exposing (padLeft)

port startTime : Time

main : Signal Html
main =
    Signal.map (view actionMailbox.address) modelSignal

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
    Signal.foldp update initialModel (Signal.merge actionMailbox.signal timeSignal)

-- mailbox for actions
actionMailbox : Signal.Mailbox Action
actionMailbox =
    Signal.mailbox Update.NoOp

initialModel : Model
initialModel =
    { time = ""
    , currentDate = Date.fromTime startTime
    , firstDayOfWeek = dayIndexToDate 0 (Date.fromTime startTime)
    , projects =
        [
            { id = 1
            , name = "Eka projekti"
            , hourEntries =
                [ { dayOfWeek = 0
                  , hours = 7.5
                  }
                , { dayOfWeek = 3
                  , hours = 7.5
                  }
                ]
            },
            { id = 2
            , name = "Toka projekti"
            , hourEntries =
                [ { dayOfWeek = 4
                  , hours = 3.5
                  }
                ]
            }
        ]
    }
