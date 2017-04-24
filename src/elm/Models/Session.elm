module Models.Session exposing (Jwt, Session, SessionData, init, login)

import Json.Decode
import Json.Decode.Pipeline
import Models.User as User exposing (User)

type alias Jwt = String

type Session
    = Authenticated SessionData
    | Unauthenticated


type alias SessionData =
    { user : User
    , jwt : Jwt
    }



sessionDataDecoder : Json.Decode.Decoder SessionData
sessionDataDecoder =
    Json.Decode.Pipeline.decode SessionData
        |> Json.Decode.Pipeline.required "user" User.userDecoder
        |> Json.Decode.Pipeline.required "token" Json.Decode.string


init : Session
init =
    Unauthenticated


login : SessionData -> Session
login sessionData =
    Authenticated sessionData



