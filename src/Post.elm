module Post exposing (main)

import Html exposing (..)
import Regex


main : Html msg
main =
    pre [] [ text post ]


regex : Maybe Regex.Regex
regex =
    Regex.fromString "\\[\\^[^]]*\\]"


post : String
post =
    """
Example of a [^note] and another [^note2] in the text.
"""


notes =
    [ ( "note", """This is the first note that contain some Elm code
```elm
-- This is elm code
```
End of note
""" )
    , ( "note2", "This is the second note" )
    ]
