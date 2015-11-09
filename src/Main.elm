module Main where

import Model exposing (..)
import Update exposing (Action, update)
import View exposing (view)
import Time exposing (Time, every, minute)
import Date exposing (year, hour, minute, second, fromTime)
import Signal exposing (Signal, Mailbox, Address)
import Html exposing (..)

currentTime : Float -> String
currentTime t =
    let date' = fromTime t
        hour' = toString (Date.hour date')
        minute' = toString (Date.minute date')
        second' = toString (Date.second date')
        year' = toString (year date')
        now = "The current time is: " ++ hour' ++ ":" ++ minute' ++ ":" ++ second'
    in
       toString now

-- manage the model of our application over time
modelSignal : Signal Model
modelSignal =
    Signal.foldp update model0 timeSignal

-- mailbox for actions
actionMailbox : Signal.Mailbox Action
actionMailbox =
    Signal.mailbox Update.NoOp

timeSignal : Signal Action
timeSignal =
    every Time.second
    |> Signal.map currentTime
    |> Signal.map Update.UpdateTime

main : Signal Html
main =
    Signal.map (view actionMailbox.address) modelSignal
