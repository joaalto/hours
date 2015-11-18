module Model where

import Date exposing (Date)

type alias Model =
    { projects : List Project
    , time : String
    , date : Maybe Date
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

emptyModel : Model
emptyModel =
    { projects = []
    , time = ""
    , date = Nothing
    }

weekDays = [ "Ma", "Ti", "Ke", "To", "Pe", "La", "Su" ]

model0 : Model
model0 =
    { time = ""
    , date = Nothing
    , projects =
        [
            { id = 1
            , name = "Eka projekti"
            , hourEntries =
                [ { dayOfWeek = 0
                  , hours = 7.5
                  }
                , { dayOfWeek = 3
                  , hours = 7.5
                  }
                ]
            },
            { id = 2
            , name = "Toka projekti"
            , hourEntries =
                [ { dayOfWeek = 4
                  , hours = 3.5
                  }
                ]
            }
        ]
    }
