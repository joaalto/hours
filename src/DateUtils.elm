module DateUtils where

import Date exposing (Date)
import Time exposing (Time)
import List exposing (indexedMap)

weekDays : List (Int, String)
weekDays =
    indexedMap (,) [ "Ma", "Ti", "Ke", "To", "Pe", "La", "Su" ]

weekDates : Time -> List Date
weekDates currentTime =
    List.map (\dayOffset -> add dayOffset currentTime)
    (dateOffsets (timeToInt currentTime))

timeToInt : Time -> Int
timeToInt time =
    (weekdayToInt << Date.dayOfWeek << Date.fromTime) time

dateOffsets : Int -> List Int
dateOffsets today =
    List.map (\day -> dayIndex today day) weekDays

dayIndex : Int -> (Int, String) -> Int
dayIndex todayIndex weekDay =
    todayIndex + (fst weekDay - todayIndex)

-- Add days to timestamp
add : Int -> Time -> Date
add days time =
    time + (toFloat days) * 1000 * 60 * 60 * 24
    -- |> toFloat
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
