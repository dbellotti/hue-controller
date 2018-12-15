port module Ports exposing (..)


-- OUTGOING

port getBridges : () -> Cmd msg

--port connectBridge : (String, String) -> Cmd msg

port triggerEpisode : String -> Cmd msg


-- INCOMING

--port newBridge : (String -> msg) -> Sub msg

port newUser : (String -> msg) -> Sub msg

