module Illustration_ImpossibleStateImpossible exposing (main)

import Playground exposing (..)


height : Float
height =
    120


width : Float
width =
    100


steep : Float
steep =
    50


distance : Float
distance =
    170


half : Float
half =
    distance / 2


sideA : Shape
sideA =
    polygon blue
        [ ( 0, 0 )
        , ( width, steep )
        , ( width, steep + height )
        , ( 0, height )
        ]


sideB : Shape
sideB =
    polygon darkBlue
        [ ( 0, 0 )
        , ( -width, steep )
        , ( -width, steep + height )
        , ( 0, height )
        ]


sideC : Shape
sideC =
    polygon lightBlue
        [ ( 0, height )
        , ( -width, height + steep )
        , ( 0, steep * 2 + height )
        , ( width, height + steep )
        ]


cube3 : Shape
cube3 =
    group
        [ sideA
        , sideB
        , sideC
        ]


cube2 : Shape
cube2 =
    group
        [ sideA
        , sideC
        ]


main : Program () Screen ( Int, Int )
main =
    picture <|
        [ group
            --
            --       1
            --           2
            --       9       3
            --                   4
            --       8       5
            --           6
            --       7
            --
            [ cube3 |> move (distance * 2) (half * 2) -- 5
            , cube3 |> move distance half -- 6
            , cube3 -- 7
            , cube3 |> move 0 distance -- 8
            , cube3 |> move 0 (distance * 2) -- 9
            , cube3 |> move 0 (distance * 3) -- 1
            , cube3 |> move distance (distance * 2.5) -- 2
            , cube3 |> move (distance * 2) (distance * 2) -- 3
            , cube3 |> move (distance * 3) (half * 3) -- 4
            , cube2 |> move (distance * 2) (half * 2) -- 5
            ]
            |> scale 0.4
            |> move -100 -160
        ]
