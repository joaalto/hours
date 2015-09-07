module Model where

type alias Model =
    { projects : List Project
    }

type alias Project =
    { id : Int
    , name : String
    , hourEntries : List HourEntry
    --, hourEntries : List HourEntry
    }

type alias HourEntry =
    { dayOfWeek : Int
    , hours : Float
    }

emptyModel : Model
emptyModel =
    { projects = []
    }

mockData : Model
mockData =
    { projects =
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

weekDays = [ "Ma", "Ti", "Ke", "To", "Pe", "La", "Su" ]

