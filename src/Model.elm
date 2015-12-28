module Model where

import Date exposing (Date)

type alias Model =
    { projects : List Project
    , time : String
    , currentDate : Date
    , firstDayOfWeek : Date
    }

type alias Project =
    { id : Int
    , name : String
    , hourEntries : List HourEntry
    }

type alias HourEntry =
    { id : Int
    , date : Date
    , hours : Float
    }
