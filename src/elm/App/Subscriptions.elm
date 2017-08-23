module App.Subscriptions exposing (..)

import App.Model exposing (Model)
import App.Messages exposing (..)

import Ports exposing (..)


subscriptions : Model -> Sub Msg
subscriptions _ =
    newUser CreateUser
    --Sub.batch
    --    [ newUser CreateUser
    --    , newBridge CreateBridge
    --    ]
