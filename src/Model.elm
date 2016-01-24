module Model where

import Date exposing (Date)
import Http

type alias Model =
    { projects : Result Http.Error (List Project)
    , httpError : Result Http.Error ()
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
    { projectId : Int
    , date : Date
    , hours : Float
    }
