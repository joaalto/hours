module Style where

import Html exposing (..)
import Html.Attributes exposing (..)

body : Attribute
body =
    style
        [ ("fontFamily", "sans-serif") ]

input : Attribute
input =
    style
        [ ("borderRadius", "4px")
        , ("textAlign", "right")
        , ("borderStyle", "solid")
        , ("borderColor", "grey")
        , ("width", "8em")
        ]

navigation : Attribute
navigation =
    style
        [ ("paddingLeft", "180px")
        , ("fontWeight", "bold")
        , ("float", "left")
        , ("paddingRight", "2em")
        ]

bold =
    style
        [ ("fontWeight", "bold") ]

floatLeft =
    style
        [ ("float", "left") ]

timer =
    style
        [ ("height", "20px")
        , ("width", "180px")
        , ("minHeight", "1px")
        ]
