module Model where

import Date exposing (Date)
import Http

type alias Model =
    { currentDate : Date
    , firstDayOfWeek : Date
    , projects : List Project
    , httpError : Result Http.Error ()
    }

type alias Project =
    { id : Int
    , name : String
    , hourEntries : List HourEntry
    }

type alias HourEntry =
    { projectId : Int
    , date : Date
    , hours : Float
    }
