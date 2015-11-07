module Main where

import StartApp.Simple as StartApp

import Model exposing (..)
import Update exposing (Action, update)
import View exposing (view)
import Time exposing (Time, every, minute)
import Date exposing (year, hour, minute, second, fromTime)
import Signal exposing (Signal, Mailbox, Address)
import Task exposing (Task)
import Html exposing (..)
import Graphics.Element exposing (Element, show)

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
model : Signal Model
model =
    Signal.foldp update model0 timeAction

-- mailbox for actions
actions : Signal.Mailbox Action
actions =
    Signal.mailbox Update.NoOp

timeAction : Signal Action
timeAction =
    Signal.map Update.UpdateTime timeSignal

timeSignal : Signal String
timeSignal =
    every Time.second
    |> Signal.map currentTime

main : Signal Html
main =
    Signal.map (view actions.address) model

