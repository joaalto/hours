module Model where

import Date exposing (Date)

type alias Model =
    { projects : List Project
    , time : String
    , currentDate : Date
    }

type alias Project =
    { id : Int
    , name : String
    , hourEntries : List HourEntry
    }

type alias HourEntry =
    { dayOfWeek : Int
    , hours : Float
    }
