module DateUtils where

import Date exposing (Date)
import List exposing (indexedMap)

weekDays : List (Int, String)
weekDays =
    indexedMap (,) [ "Ma", "Ti", "Ke", "To", "Pe", "La", "Su" ]

dayIndexToDate : Int -> Date -> Date
dayIndexToDate index currentDate =
    add (dateOffset index currentDate) currentDate

dateOffset : Int -> Date -> Int
dateOffset day currentDate =
    dayIndex (dateToWeekdayIndex currentDate) day

dayIndex : Int -> Int -> Int
dayIndex todayIndex weekDay =
    todayIndex + (weekDay - todayIndex)

-- weekDates : Time -> List Date
-- weekDates currentTime =
--     List.map (\dayOffset -> add dayOffset currentTime)
--     (dateOffsets (timeToWeekdayIndex currentTime))

dateToWeekdayIndex : Date -> Int
dateToWeekdayIndex date =
    (weekdayToInt << Date.dayOfWeek) date

-- dateOffsets : Int -> List Int
-- dateOffsets today =
--     List.map (\day -> dayIndex today day) weekDays

-- Add days to timestamp
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
