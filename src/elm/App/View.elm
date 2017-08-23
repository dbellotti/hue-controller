module App.View exposing (..)

import String exposing (isEmpty)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import App.Model exposing (..)
import App.Messages exposing (..)


navbarView : Model -> Html Msg
navbarView model =
    nav [ class "navbar navbar-inverse navbar-fixed-top" ]
        [ div [ class "container" ]
              [ div [ class "navbar-header" ]
                    [ button
                          [ type_ "button"
                          , class "navbar-toggle collapsed"
                          , attribute "data-toggle" "collapse"
                          , attribute "data-target" "#navbar"
                          , attribute "aria-expanded" "false"
                          , attribute "aria-controls" "navbar"
                          ]
                          [ span [ class "sr-only" ] [ text "Toggle navigation" ]
                          , span [ class "icon-bar" ] []
                          , span [ class "icon-bar" ] []
                          , span [ class "icon-bar" ] []
                          ]
                    , a [ class "navbar-brand", href "/" ] [ text "Game of Hues" ]
                    ]
              , div [ id "navbar", class "collapse navbar-collapse" ]
                    [ ul [ class "nav navbar-nav" ]
                          [ li [ class "active" ]
                                [ a [ href "/elm" ] [ text "Elm Version" ]
                                ]
                          , li []
                                [ if isEmpty model.bridge then
                                      text ""
                                  else
                                      a [ href "/party_time" ] [ text "PartyTime" ]
                                ]
                          , li []
                                [ if isEmpty model.flash then
                                      text ""
                                  else
                                      span [ class "label label-default" ] [ text model.flash ]
                                ]
                          , li []
                                [ if isEmpty model.bridge then
                                      text ""
                                  else
                                      a [ href "#", title model.user ] [ text model.bridge ]
                                ]
                          ]
                    ]
              ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ navbarView model
        , div [ class "container" ]
              [ div [ class "page-header" ]
                    [ h1 [] [ text "Lord of Light" ]
                    , p [ class "lead" ]
                          [ text "Winter is here, but the Lord of Light will deliver us from darkness."
                          , br [] []
                          , text "Use the tools bestowed upon you to fulfill your destiny and save the world from winter."
                          ]
                    ]
              , div [ class "jumbotron locations" ]
                    [ if (isEmpty model.user) then
                          jumbotronEmptyView
                      else
                          jumbotronAuthenticatedView model
                    ]
              ]
        ]


jumbotronEmptyView : Html Msg
jumbotronEmptyView =
    div []
        [ p []
              [ text """
                   You need to register your Hue base station by pressing
                   the button on the top then clicking the 'Register Base Station'
                   button below.
                   """
              ]
        , div [ class "register-button-group" ] []
        ]


jumbotronAuthenticatedView : Model -> Html Msg
jumbotronAuthenticatedView model =
    div []
        []
    --    [ button [ class "btn btn-lg btn-info", onClick (TriggerScene 3) ]
    --          [ text "Trigger Episode 3" ]
    --    , button [ class "btn btn-lg btn-info", onClick (TriggerScene 4) ]
    --          [ text "Trigger Episode 4" ]
    --    ]

