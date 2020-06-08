module Main exposing (..)
import Html exposing (Html, img, h5, p, a, div, button, text)
import Html.Attributes exposing (attribute, id, class, style, src, href)
import Html.Events exposing (onClick)
import Browser exposing(UrlRequest)
import Browser.Navigation
import Debug
import Url
import Url.Parser exposing (Parser, (</>), (<?>), int, map, oneOf, s, string)
import Url.Parser.Query as Query
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

type alias Config = 
  {
    me:String
    ,other: String
    ,question: String
  }
type alias Model = 
  {
    url: Url.Url
    ,config: Config
  }

{- parseParam: String -> Url.Parser.Parser (Maybe String -> String) String
parseParam p= s "/" <?> Query.string p -}

type Route
  = BlogQuery (Maybe String)
  | MyParam ()

routeParser : Parser (Route -> a) a
routeParser =
  oneOf
    [ map BlogQuery (s "blog" <?> Query.string "q") ]

getParam: Maybe String
getParam = s "path" </> string

buildInit: Url.Url -> Model
buildInit url = 
  {
    url=url,
    config={
      me="Neuber"
      ,question="Quem é o melhor marido do mundo?" 
      ,other="KAJSHDKJSAHD"
    }
  }
init: () -> Url.Url -> Browser.Navigation.Key -> (Model, Cmd String) 
init _ url key = (Debug.log "INIT" (buildInit url), Cmd.none)

urlRequestHandler : UrlRequest -> String
urlRequestHandler req = "request"

urlChangeHandler: Url.Url -> String
urlChangeHandler url = "url ???"

subscriptionsHandler: model -> Sub msg
subscriptionsHandler model = Sub.none

update : msg -> Model -> ( Model, Cmd msg )
update c m = (m, Cmd.none)

view : Model -> Browser.Document msg
view md = 
  { 
    title = "Happy Valentine's day from ELM", 
    body = [
      div [class "container-fluid"] [
        div [class "row justify-content-center align-items-center"] [
          div [class "card", style "width" "23rem"] [
            img [ src "assets/img/card4.jpg", class "card-img-top"] []
            ,div [class "card-body"] [
              h5 [class "card-title"] [text "Teste"]
              ,p [class "card-text"] [text md.config.question]

              ,div [class "row justify-content-between"] [
                button [id "btWin", class "btn btn-danger", attribute "data-toggle" "modal", attribute "data-target" "#win-modal", attribute "type" "button"] [text md.config.me]
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
        ]
      ]
    ]
  }
    