module Main where

import Model exposing (..)
import Update exposing (Action, update)
import View exposing (view)
import Time exposing (Time, every, minute)
import Date exposing (Date, hour, minute, second, fromTime)
import Signal exposing (Signal, Mailbox, Address)
import Html exposing (..)

port startTime : Signal Int

-- main = Signal.map show startTime
main : Signal Html
main =
    Signal.map (view actionMailbox.address) modelSignal

currentTime : Float -> String
currentTime t =
    let date' = fromTime t
        hour' = toString (Date.hour date')
        minute' = toString (Date.minute date')
        second' = toString (Date.second date')
    in
        "Current time: " ++ hour' ++ ":" ++ minute' ++ ":" ++ second'

timeSignal : Signal Action
timeSignal =
    every Time.second
    |> Signal.map currentTime
    |> Signal.map Update.UpdateTime

dateSignal : Signal Action
dateSignal =
    every Time.minute
    |> Signal.map Date.fromTime
    |> Signal.map Update.UpdateDate

-- manage the model of our application over time
modelSignal : Signal Model
modelSignal =
    Signal.foldp update model0 (Signal.merge timeSignal dateSignal)

-- mailbox for actions
actionMailbox : Signal.Mailbox Action
actionMailbox =
    Signal.mailbox Update.NoOp
