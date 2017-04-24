module Main exposing (..)

import Html as H exposing (Html)
import Html.Attributes as HA
import Models.Session as Session
import Navigation
import Pages.Home as Home
import Routing exposing (Route(..))
import SessionStorage


-- APP


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( model location, Cmd.none )


type alias Model =
    { route : Routing.Route
    , session : Session.Session
    , homeModel : Home.Model
    }


model : Navigation.Location -> Model
model location =
    { route = HomeRoute Home.emptyParams
    , session = Session.init
    , homeModel = Home.init
    }



-- UPDATE


type Msg
    = UrlChanged Navigation.Location
    | ChangeRoute Routing.Route
    | HomeMsg Home.Msg
    | SessionStorageMsg SessionStorage.Msg
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        UrlChanged location ->
            let
                route = Routing.locationToRoute location
            in
                update ( ChangeRoute route ) model


        ChangeRoute route ->
            let
                newModel = { model | route = route }
            in
                case route of
                    HomeRoute params ->
                        ( newModel
                        , Home.activate model.session params
                              |> Cmd.map HomeMsg
                        )

                    NotFound ->
                        ( newModel, Cmd.none )


        SessionStorageMsg (SessionStorage.SessionLoaded sessionData) ->
            ( { model
                  | session = Session.login sessionData
              }
            , Cmd.none
            )


        HomeMsg homeMsg ->
            let
                ( homeModel, cmdMsg ) =
                    Home.update homeMsg model.homeModel
            in
                ( { model | homeModel = homeModel }
                , Cmd.map HomeMsg cmdMsg
                )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map SessionStorageMsg SessionStorage.subscriptions
        ]



-- VIEW


view : Model -> Html Msg
view model =
    let
        content = viewContent model
    in
        H.div
            []
            [ H.h1 [] [ H.text "Elm Seed" ]
            , H.div [ HA.class "content" ] [ content ]
            ]


viewContent : Model -> Html Msg
viewContent model =
    case model.route of
        HomeRoute params ->
            Home.view model.homeModel model.session
                |> H.map HomeMsg


        NotFound ->
            H.div [] [ H.h1 [] [ H.text "Never heard of that url dude"]]

-- Start me!


main : Program Never Model Msg
main =
    Navigation.program UrlChanged
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
