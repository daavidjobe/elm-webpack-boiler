module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- APP


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }


type alias Model =
    { title : String, description : String }


model : Model
model =
    { title = "Elm Webpack Boilerplate"
    , description = "Production & development builds with sass configured. No css frameworks"
    }



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "wrapper" ]
        [ h1 [] [ text model.title ]
        , p [] [ text model.description ]
        ]
