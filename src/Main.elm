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
  Signal.foldp update model0 actions.signal

-- actions from user input
actions : Signal.Mailbox Action
actions =
  Signal.mailbox Update.NoOp

--
timeSignal : Signal String
timeSignal =
  every Time.second
  --|> Signal.map currentTime taskMailbox.signal
  |> Signal.map currentTime
--}

taskMailbox : Mailbox String --(Task error value)
taskMailbox =
  Signal.mailbox ""

-- Actually perform all those tasks
{--}
port runner : Signal String --(Task x ())
port runner =
  timeSignal
--}

{--
mainy : Signal String
mainy =
  Signal.map currentTime taskMailbox.signal
--}

{--}
main : Signal Html
main =
  --Signal.map currentTime model
  Signal.map (view actions.address) model
--}
{--
mainx =
    StartApp.start
    { model = model
    , update = update
    , view = view }
--}

