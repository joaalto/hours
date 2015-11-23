module DateUtils where

import Date exposing (Date)
import List exposing (indexedMap)

weekDays : List (Int, String)
weekDays =
    indexedMap (,) [ "Ma", "Ti", "Ke", "To", "Pe", "La", "Su" ]

dates : Int -> List Int
dates today =
    List.map (\day -> date today day) weekDays

date : Int -> (Int, String) -> Int
date today weekDay =
    today + (fst weekDay - today)

-- Add days to timestamp
add : Int -> Int -> Date
add days time =
    time + days * 1000 * 60 * 60 * 24
    |> toFloat
    |> Date.fromTime
