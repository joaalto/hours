module Main where

import StartApp.Simple as StartApp

import Model exposing (..)
import Update exposing (update)
import View exposing (view)

main =
    StartApp.start
    { model = mockData
    , update = update
    , view = view }

