module Main where

import StartApp.Simple as StartApp

import Model exposing (..)
import Update exposing (update)
import View exposing (view)
import Time exposing (Time, every, minute)
import Date exposing (year, hour, minute, second, fromTime)
import Signal exposing (Signal, Address)
import Task exposing (Task)
import Html exposing (..)
import Graphics.Element exposing (Element, show)

timeSignal : Signal String
timeSignal =
  every Time.second
  |> Signal.map currentTime

currentTime : Float -> String
currentTime t =
  let date' = fromTime t
      hour' = toString (Date.hour date')
      minute' = toString (Date.minute date')
      second' = toString (Date.second date')
      year' = toString (year date')
      now = "The current time is: " ++ hour' ++ ":" ++ minute' ++ ":" ++ second'
  in 
      now

contentMailbox : Signal.Mailbox String
contentMailbox =
  Signal.mailbox ""

-- Actually perform all those tasks
{--
port runner : Signal (Task x ())
port runner =
  timeSignal
--}

main =
    StartApp.start
    { model = mockData
    , update = update
    , view = view }

