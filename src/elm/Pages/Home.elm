module Pages.Home
    exposing
        ( Model
        , Params
        , init
        , Msg
        , update
        , view
        , activate
        , emptyParams
        , parseParams
        )

import Html as H exposing (Html)
import Models.Session as Session exposing (Session)
import Models.Session as Session exposing (Session)
import Navigation


type ParamsError
    = ReplaceMeWithSomeActualError String


type alias Params =
    {}


emptyParams : Params
emptyParams =
    {}


parseParams : Navigation.Location -> Result ParamsError Params
parseParams location =
    Ok {}


type alias Model =
    { params : Params
    , title : String
    , quote : String
    }


init : Model
init =
    { params = {}
    , title = "HomeRoute"
    , quote = "Everything that exists is in a manner the seed of that which will be"
    }


activate : Session -> Params -> Cmd Msg
activate session params =
    Cmd.none


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> Session -> Html Msg
view model session =
    H.div
        []
        [ H.h2
            []
            [ H.text model.title ]
        , H.p
            []
            [ H.text model.quote ]
        ]
