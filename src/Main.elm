module Main where

import Signal exposing (Signal, Address)
import StartApp.Simple as StartApp
import Date

import Model exposing (..)
import Update exposing (update)
import View exposing (view)

main =
    StartApp.start
    { model = mockData
    , update = update
    , view = view }

