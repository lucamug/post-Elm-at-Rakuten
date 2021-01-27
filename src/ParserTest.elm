module ParserTest exposing (main)

import Browser
import Element exposing (..)
import Html
import Html.Events exposing (onClick)
import Parser exposing (..)



-- # Trivial
--
-- int    : Parser Int   --
-- float  : Parser Float --
-- end    : Parser ()    -- The end of the string
-- spaces : Parser ()    -- Zero or more spaces
--
-- # Normal
--
-- symbol          : String -> Parser ()
-- keyword         : String -> Parser ()
-- token           : String -> Parser ()
-- lineComment     : String -> Parser ()
-- chompUntil      : String -> Parser ()
-- chompUntilEndOr : String -> Parser ()
--
-- # Advanced parsers
--
-- number   : ... -> Parser a
-- variable : ... -> Parser String


f : Parser Float
f =
    float


test : String
test =
    "fsfdfxxx[[d]]fdsfsd[[f]]gfgfddf"


main : Html.Html msg
main =
    layout [ padding 40 ] <|
        column [ spacing 20 ]
            [ text "Examples"

            -- , text <| Debug.toString <| run int "123456"
            -- , text <| Debug.toString <| run int "3.1415"
            -- , text <| Debug.toString <| run (keyword "true") "true!"
            -- , text <| Debug.toString <| run int "-123"
            -- , text <| Debug.toString <| run myInt "-123"
            -- , text <| Debug.toString <| run elmNumber "0xFFFF"
            -- , text <| Debug.toString <| run (symbol "[") "["
            -- , text <| Debug.toString <| run (symbol "[") "4"
            , text <| Debug.toString <| run point test
            , text <| Debug.toString <| run g test
            ]


myInt : Parser Int
myInt =
    oneOf
        [ succeed negate
            |. symbol "-"
            |= int
        , int
        ]


type Expr
    = Variable String
    | Int Int
    | Float Float
    | Apply Expr Expr


elmNumber : Parser Expr
elmNumber =
    number
        { int = Just Int
        , hex = Just Int -- 0x001A is allowed
        , octal = Nothing -- 0o0731 is not
        , binary = Nothing -- 0b1101 is not
        , float = Just Float
        }


type alias Point =
    { x : Float
    , y : Float
    }


a : Float -> Float -> Point
a =
    Point


getChompedString : Parser a -> Parser String
getChompedString parser =
    succeed String.slice
        |= getOffset
        |. parser
        |= getOffset
        |= getSource


g : Parser String
g =
    getChompedString <| point


point : Parser { x : String }
point =
    succeed (\x -> { x = x })
        |. chompWhile (\c -> Char.isAlphaNum c || c == '_')
        |. symbol "[["
        |. spaces
        |= oneChar
        |. spaces
        |. spaces
        |. symbol "]]"
        |. chompWhile (\c -> Char.isAlphaNum c || c == '_')


oneChar : Parser String
oneChar =
    getChompedString <|
        succeed ()
            |. chompIf Char.isAlpha
