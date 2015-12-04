module Tests where

import ElmTest exposing (..)
import String
import Date exposing (Date)

import DateUtils exposing (..)

all : Test
all =
    suite "Test date utils"
        [
            test "dateToWeekdayIndex" (assertEqual 4 (dateToWeekdayIndex date)),
            test "weekday" (assertEqual Date.Fri (Date.dayOfWeek date)),
            test "day" (assertEqual 4 (Date.day date))
        ]

date : Date
date = case Date.fromString "2015-12-04" of
    Err str -> Debug.crash str
    Ok date -> date
