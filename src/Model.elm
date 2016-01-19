module Model where

import Date exposing (Date)
import Http

type alias Model =
    { projects : Result Http.Error (List Project)
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
    , projectId : Int
    , date : Date
    , hours : Float
    }

type alias NewHourEntry =
    { projectId: Int
    , date : Date
    , hours : Float
    }
