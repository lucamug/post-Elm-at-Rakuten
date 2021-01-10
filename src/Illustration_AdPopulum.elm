module Illustration_AdPopulum exposing (main)

import Playground exposing (..)



{-
   <html>
   <head>
     <style>
       svg {background: radial-gradient(farthest-side at 1000px 140px,  rgb(100, 187, 232), rgb(3, 94, 142))}
     </style>
   </head>
   <body>
     <main></main>
     <script>
       var app = Elm.Main.init({ node: document.querySelector('main') })
     </script>
   </body>
   </html>
-}


size :
    { diagonal : Float
    , half : Float
    , forth : Float
    , margin : Float
    }
size =
    let
        half =
            100
    in
    { half = half
    , forth = half / 2
    , diagonal = sqrt (half ^ 2 * 2)
    , margin = 5
    }


baseColor :
    { gray1 : Color
    , gray2 : Color
    , gray3 : Color
    , yellow1 : Color
    , yellow2 : Color
    , yellow3 : Color
    }
baseColor =
    { gray1 = rgb 205 205 200
    , gray2 = rgb 230 230 230
    , gray3 = rgb 180 165 180
    , yellow1 = rgb 255 250 10
    , yellow2 = rgb 255 230 10
    , yellow3 = rgb 255 210 10
    }


type alias Palette =
    { c1 : Color
    , c2 : Color
    , c3 : Color
    , c4 : Color
    , c5 : Color
    , c6 : Color
    , c7 : Color
    }


palette1 : Palette
palette1 =
    { c1 = baseColor.gray1
    , c2 = baseColor.gray2
    , c3 = baseColor.gray3
    , c4 = baseColor.gray1
    , c5 = baseColor.gray2
    , c6 = baseColor.gray3
    , c7 = baseColor.gray1
    }


palette2 : Palette
palette2 =
    { c1 = baseColor.yellow1
    , c2 = baseColor.yellow2
    , c3 = baseColor.yellow3
    , c4 = baseColor.yellow1
    , c5 = baseColor.yellow2
    , c6 = baseColor.yellow1
    , c7 = baseColor.yellow3
    }


shape :
    Color
    ->
        { polygon : Shape
        , polygonMirror : Shape
        , square : Shape
        , triangleLarge : Shape
        , triangleMedium : Shape
        , triangleMediumSpecialForMargin : Shape
        , triangleSmall : Shape
        }
shape color =
    { square = square color (size.diagonal / 2)
    , triangleLarge = polygon color [ ( 0, 0 ), ( 0, size.diagonal ), ( size.diagonal, 0 ) ]
    , triangleMedium = polygon color [ ( 0, 0 ), ( 0, size.half ), ( size.half, 0 ) ]
    , triangleMediumSpecialForMargin = polygon color [ ( 0, 0 ), ( 0, size.half + size.margin ), ( size.half + size.margin, 0 ) ]
    , triangleSmall = polygon color [ ( 0, 0 ), ( 0, size.diagonal / 2 ), ( size.diagonal / 2, 0 ) ]
    , polygon = polygon color [ ( 0, 0 ), ( size.half, 0 ), ( size.forth, size.forth ), ( -size.forth, size.forth ) ]
    , polygonMirror = polygon color [ ( 0, 0 ), ( -size.half, 0 ), ( -size.forth, size.forth ), ( size.forth, size.forth ) ]
    }


tangram : List Shape
tangram =
    [ .triangleLarge (shape yellow) |> rotate -135
    , .triangleLarge (shape lightGreen) |> rotate 135
    , .square (shape yellow) |> rotate 45 |> move size.forth 0
    , .triangleMedium (shape brown) |> rotate 180 |> move size.half size.half
    , .triangleSmall (shape yellow) |> rotate 45
    , .triangleSmall (shape lightBlue) |> rotate -45 |> move size.forth -size.forth
    , .polygon (shape gray) |> move -size.forth size.forth
    ]


tangramWithMargin : List Shape
tangramWithMargin =
    let
        shapeWhite =
            shape white
    in
    [ shapeWhite.triangleLarge |> rotate -135
    , shapeWhite.triangleLarge |> rotate 135 |> move -size.margin size.margin
    , shapeWhite.square |> rotate 45 |> move size.forth 0 |> move size.margin size.margin
    , shapeWhite.triangleMediumSpecialForMargin |> rotate 180 |> move size.half size.half |> move (size.margin * 2) (size.margin * 3)
    , shapeWhite.triangleSmall |> rotate 45 |> move 0 (size.margin * 2)
    , shapeWhite.triangleSmall |> rotate -45 |> move size.forth -size.forth |> move (size.margin * 2) 0
    , shapeWhite.polygon |> move -size.forth size.forth |> move -size.margin (size.margin * 3)
    ]


fish1 : List Shape
fish1 =
    [ .triangleLarge (shape <| baseColor.gray1) |> rotate -45
    , .triangleLarge (shape <| baseColor.gray2) |> rotate 135 |> move 200 0 |> move 7 0
    , .square (shape <| baseColor.gray3) |> rotate 45 |> move size.forth 0 |> move 0 -100 |> move 0 -10
    , .triangleMedium (shape <| baseColor.gray3) |> rotate 135
    , .triangleSmall (shape <| baseColor.gray1) |> rotate 135 |> move 50 -150 |> move -6 -16
    , .triangleSmall (shape <| baseColor.gray3) |> rotate 135 |> move 100 100 |> move -3 8
    , .polygonMirror (shape <| baseColor.gray1) |> rotate 90 |> move 50 150 |> move -11 14
    ]


fish2 : List Shape
fish2 =
    [ .triangleLarge (shape <| baseColor.gray1) |> rotate -45
    , .triangleLarge (shape <| baseColor.gray2) |> rotate 135 |> move 200 0
    , .square (shape <| baseColor.gray3) |> rotate 45 |> move size.forth 0 |> move 0 -100
    , .triangleMedium (shape <| baseColor.gray3) |> rotate 135
    , .triangleSmall (shape <| baseColor.gray1) |> rotate 135 |> move 50 -150
    , .triangleSmall (shape <| baseColor.gray3) |> rotate 135 |> move 100 100
    , .polygonMirror (shape <| baseColor.gray1) |> rotate 90 |> move 50 150
    ]


fish3 : Palette -> List Shape
fish3 palette =
    [ .triangleLarge (shape <| palette.c1) |> rotate -90
    , .triangleLarge (shape <| palette.c2) |> rotate 0 |> move 0 6
    , .square (shape <| palette.c3) |> move size.forth 0 |> move -91 4
    , .triangleMedium (shape <| palette.c4) |> rotate 135 |> move -82 46
    , .triangleSmall (shape <| palette.c5) |> rotate 90 |> move -5.5 46
    , .triangleSmall (shape <| palette.c6) |> rotate 180 |> move -6 -37
    , .polygonMirror (shape <| palette.c7) |> rotate 45 |> move -82 -33
    ]


fishSmall1 : Shape
fishSmall1 =
    group fish1 |> scale 0.14 |> rotate 120


fishSmall3 : Palette -> Shape
fishSmall3 palette =
    group (fish3 palette) |> move -5 10 |> scale 0.14 |> rotate 120


shoal : Int -> (Int -> Int -> a) -> List a
shoal qty f =
    List.concat
        (List.indexedMap
            (\y _ ->
                List.indexedMap
                    (\x _ ->
                        f x y
                    )
                    (List.repeat qty ())
            )
            (List.repeat qty ())
        )


ripple : Shape
ripple =
    polygon white [ ( 0, 0 ), ( 6, 6 ), ( 9, 8 ), ( 15, 10 ), ( 23, 10 ), ( 28, 9 ), ( 34, 6 ), ( 37, 4 ), ( 42, 0 ), ( 36, 6 ), ( 29, 10 ), ( 26, 11 ), ( 22, 12 ), ( 16, 12 ), ( 12, 11 ), ( 9, 10 ), ( 6, 8 ), ( 3, 5 ) ]


elmLogo : Shape
elmLogo =
    group ((square blue 226 |> move 3 7) :: tangramWithMargin)


fishes : Shape
fishes =
    group
        (shoal 5
            (\x y ->
                (if x == 3 && y == 2 then
                    group []

                 else
                    fishSmall3 palette1
                )
                    |> move
                        (70 * toFloat x)
                        (70 * toFloat y)
            )
        )


main : Program () Screen ( Int, Int )
main =
    picture <|
        [ fishes |> rotate 45 |> move -200 -200 |> fade 0.7
        , fishSmall3 palette2 |> move 20 180 |> rotate -130 |> scale 1.4
        , ripple |> scale 4 |> rotate 45 |> fade 0.5 |> move -160 70
        , ripple |> scale 2 |> rotate 40 |> fade 0.5 |> move -150 80
        ]
