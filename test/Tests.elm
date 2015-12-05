module Tests where

import ElmTest exposing (..)
import Date exposing (Date)

import DateUtils exposing (..)

all : Test
all =
    suite "Test date utils"
        [
            test "weekday" (assertEqual Date.Fri (Date.dayOfWeek date)),
            test "day" (assertEqual 4 (Date.day date)),
            test "dateOffset" (assertEqual -1 (dateOffset 3 date))
        ]

date : Date
date =
    case Date.fromString "2015-12-04" of
        Err str -> Debug.crash str
        Ok date -> date
