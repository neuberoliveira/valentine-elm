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
    ,update=update
    ,view=view
    ,onUrlRequest=urlRequestHandler
    ,onUrlChange=urlChangeHandler
    ,subscriptions=subscriptionsHandler
  }

-- MODEL
type alias Model = 
  {
    navKey: Browser.Navigation.Key
  }


init: flags -> Url.Url -> Browser.Navigation.Key -> ( model, Cmd msg )
-- init:String
init = 

urlChangeHandler : Url.Url -> msg
urlChangeHandler url = "url changed"

urlRequestHandler : UrlRequest -> msg
urlRequestHandler req = Debug.log "req" req

subscriptionsHandler : String -> Sub msg
subscriptionsHandler model =
    Sub.none


type ClickType = Me | Other
update: ClickType -> String -> ( model, Cmd msg )
update ctype _ = 
  case ctype of
    Me -> "good choice"
    Other -> "dont kid me"

view : String -> Html msg
view str = 
    div [class "card", style "width" "18rem"] [
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


{- 
<div class="card" style="width: 18rem;">
  <img src="..." class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the cards content.</p>
    <a href="#" class="btn btn-primary">Go somewhere</a>
  </div>
</div>
 -}