module Models.Id exposing (Id, idDecoder)

import Json.Decode


type alias Id = String


idDecoder : Json.Decode.Decoder Id
idDecoder =
    Json.Decode.string
