module Main exposing (..)
import Html exposing (Html, img, h5, p, a, div, button, text)
import Html.Attributes exposing (attribute, id, class, style, src, href)
import Html.Events exposing (onClick)
import Browser exposing(UrlRequest)
import Browser.Navigation
import Url

import Debug
import Modal

main = Browser.application
  {
    init=init
    ,view=view
    ,update=update
    ,subscriptions=subscriptionsHandler
    ,onUrlRequest=urlRequestHandler
    ,onUrlChange=urlChangeHandler
  }

type alias Model = String

init: () -> Url.Url -> Browser.Navigation.Key -> (Model, Cmd String ) 
init f u k = ("asfjhgsadh", Cmd.none)

urlRequestHandler : UrlRequest -> String
urlRequestHandler req = "Request ???"

urlChangeHandler: Url.Url -> String
urlChangeHandler url = "url ???"

subscriptionsHandler: model -> Sub msg
subscriptionsHandler model = Sub.none

update : msg -> Model -> ( Model, Cmd msg )
update c m = ("Update", Cmd.none)

applicationView: Html msg
applicationView = div [class "card", style "width" "18rem"] [
      img [ src "assets/img/card2.jpg", class "card-img-top"] []
      ,div [class "card-body"] [
        h5 [class "card-title"] [text "Teste"]
        ,p [class "card-text"] [text "Quem é o melhor marido do mundo?"]

        ,div [class "row justify-content-between"] [
          button [id "btWin", class "btn btn-danger", attribute "data-toggle" "modal", attribute "data-target" "#win-modal", attribute "type" "button"] [text "Neuber"]
          ,button [id "btFail", class "btn btn-danger", attribute "data-toggle" "modal", attribute "data-target" "#fail-modal", attribute "type" "button"] [text "Outro"]
        ]
      ]
      
      ,Modal.render {
        title = "Huuuhu!!!!" 
        ,okText ="OK"
        ,content ="Eu sabia !!! huahsuhsuhsusu"
        ,id = "win-modal"
      }
      
      ,Modal.render {
        title = ":)" 
        ,okText ="OK"
        ,content ="Deixa de ser besta hahaha"
        ,id = "fail-modal"
      }
    ]

view : model -> Browser.Document msg
view md = 
  { 
    title="Hello from ELM", 
    body= [
      div [class "container-fluid"] [
        div [class "row justify-content-center align-items-center"] [applicationView]
      ]
    ]
  }
    