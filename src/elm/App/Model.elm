module App.Model exposing (..)

import String exposing (isEmpty)
import App.Messages exposing (Msg)
import Ports exposing (..)


type alias Model =
    { user   : String
    , bridge : String
    , flash  : String
    }


type alias Flags =
    { user   : String
    , bridge : String
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        startCmd =
            getBridges ()
            --if isEmpty flags.bridge || isEmpty flags.user then
            --    getBridges ()
            --else
            --    connectBridge (flags.bridge, flags.user)

    in
        ( { user = flags.user, bridge = flags.bridge, flash = "" }, startCmd )
