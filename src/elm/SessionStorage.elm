port module SessionStorage
    exposing
        ( Msg(..)
        , subscriptions
        , saveSession
        , clearSession
        )

import Models.Session exposing (SessionData)


type Msg
    = SessionLoaded SessionData


port saveSession : SessionData -> Cmd msg


port clearSession : () -> Cmd msg


port loadSession : (SessionData -> msg) -> Sub msg


subscriptions : Sub Msg
subscriptions =
    loadSession SessionLoaded
