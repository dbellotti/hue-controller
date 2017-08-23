module App.Update exposing (..)

import App.Model exposing (Model)
import App.Messages exposing (..)
import Ports exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        CreateUser user ->
            ( { model | user = user }, Cmd.none )
            -- TODO - wire into API call /auth?user=user
            -- TODO - render/show episode buttons, westeros, and themes

        --CreateBridge bridge ->
        --    ( { model | bridge = bridge }, Cmd.none )

        --TriggerScene id ->
        --    ( model, triggerEpisode (toString id) )

