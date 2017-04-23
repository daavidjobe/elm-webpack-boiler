module Models.User exposing (User, userDecoder)


import Json.Decode
import Json.Decode.Pipeline
import Models.Id exposing (Id, idDecoder)


type alias User =
    { id : Id
    , username : String
    }


userDecoder : Json.Decode.Decoder User
userDecoder =
    Json.Decode.Pipeline.decode User
        |> Json.Decode.Pipeline.required "id" idDecoder
        |> Json.Decode.Pipeline.required "username" Json.Decode.string
