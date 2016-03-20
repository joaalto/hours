module DateUtils (..) where

import Date exposing (Date, day, month)
import List exposing (indexedMap)
import Date.Format exposing (format)


weekDays : List ( Int, String )
weekDays =
  indexedMap (,) [ "Ma", "Ti", "Ke", "To", "Pe", "La", "Su" ]


dayIndexToDateString : Int -> Date -> String
dayIndexToDateString index currentDate =
  format "%d.%m." (dayIndexToDate index currentDate)


sameDate : Date -> Date -> Bool
sameDate date1 date2 =
  fullDate date1 == fullDate date2


fullDate : Date -> String
fullDate date =
  format "%Y-%m-%d" date


dayIndexToDate : Int -> Date -> Date
dayIndexToDate index currentDate =
  addDaysToDate (dateOffset index currentDate) currentDate


dateOffset : Int -> Date -> Int
dateOffset index currentDate =
  index - (weekdayToInt << Date.dayOfWeek) currentDate


addDaysToDate : Int -> Date -> Date
addDaysToDate days date =
  Date.toTime date
    + (toFloat days)
    * 86400000
    |> Date.fromTime


weekdayToInt : Date.Day -> Int
weekdayToInt dow =
  case dow of
    Date.Mon ->
      0

    Date.Tue ->
      1

    Date.Wed ->
      2

    Date.Thu ->
      3

    Date.Fri ->
      4

    Date.Sat ->
      5

    Date.Sun ->
      6
