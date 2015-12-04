module DateUtils where

import Date exposing (Date, day, month)
import List exposing (indexedMap)
import Debug exposing (log)
import Date.Format exposing (format)

weekDays : List (Int, String)
weekDays =
    indexedMap (,) [ "Ma", "Ti", "Ke", "To", "Pe", "La", "Su" ]

dayIndexToDateString : Int -> Date -> String
dayIndexToDateString index currentDate =
    format "%d.%m." (dayIndexToDate index currentDate)

dayIndexToDate : Int -> Date -> Date
dayIndexToDate index currentDate =
    add (dateOffset index currentDate) currentDate

dateOffset : Int -> Date -> Int
dateOffset index currentDate =
    index - ((weekdayToInt << Date.dayOfWeek) currentDate)

-- Add days to date
add : Int -> Date -> Date
add days date =
    Date.toTime date + (toFloat days) * 1000 * 60 * 60 * 24
    |> Date.fromTime

weekdayToInt : Date.Day -> Int
weekdayToInt dow =
    case dow of
        Date.Mon -> 0
        Date.Tue -> 1
        Date.Wed -> 2
        Date.Thu -> 3
        Date.Fri -> 4
        Date.Sat -> 5
        Date.Sun -> 6
