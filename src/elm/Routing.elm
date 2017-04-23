module Routing exposing (Route(..), init, locationToRoute)

import Navigation
import Pages.Home as Home



locationToRoute : Navigation.Location -> Route
locationToRoute location =
    NotFound



init : Route
init =
    NotFound


type Route
    = NotFound
    | HomeRoute Home.Params



requiresLogin : Route -> Bool
requiresLogin route =
    case route of
        NotFound -> False

        _ -> True
