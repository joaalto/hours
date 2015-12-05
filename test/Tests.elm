module Tests where

import ElmTest exposing (..)
import Date exposing (Date)

import DateUtils exposing (..)

all : Test
all =
    suite "Test date utils"
        [
            test "weekday" (assertEqual Date.Fri (Date.dayOfWeek testDate)),
            test "day" (assertEqual 4 (Date.day testDate)),
            test "dateOffset" (assertEqual -1 (dateOffset 3 testDate)),
            test "dayIndexToDateString"
                (assertEqual "30.11." (dayIndexToDateString 0 testDate))
        ]

testDate : Date
testDate =
    case Date.fromString "2015-12-04" of
        Err str -> Debug.crash str
        Ok date -> date
