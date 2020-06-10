module Main exposing (..)
import Html exposing (Html, img, h5, p, a, div, span, button, text)
import Html.Attributes exposing (attribute, id, class, style, src, href)
import Html.Events exposing (onClick)
import Browser exposing(UrlRequest)
import Browser.Navigation
import Debug
import Url
import Url.Parser as Parser exposing ((</>), (<?>))
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
    from:String
    ,to: String
    ,other: String
    ,question: String
  }
type alias Model = 
  {
    url: Url.Url
    ,config: Config
  }

emojiToString : Int -> String
emojiToString code =String.fromChar (Char.fromCode code)

getParam : Url.Url -> String -> String -> String
getParam url paramName defaultValue = 
  -- let parsedParam = (Parser.parse (Parser.s "src" </> Parser.s "Main.elm" <?> (Query.string paramName)) url)
  let parsedParam = (Parser.parse (Parser.s "dist" </> Parser.s "index.html" <?> (Query.string paramName)) url)
  in
  case parsedParam of
    Nothing -> defaultValue
    Just qs -> case qs of
      Just qsval -> qsval
      Nothing -> defaultValue

buildInit: Url.Url -> Model
buildInit url = 
  {
    url=url,
    config={
      from=getParam url "from" "Neuber"
      ,to=getParam url "to" "Lilian"
      ,question=getParam url "question" "Quem é o melhor marido do mundo?" 
      ,other=getParam url "other" "Outro"
    }
  }
init: () -> Url.Url -> Browser.Navigation.Key -> (Model, Cmd String) 
init _ url key = (buildInit url, Cmd.none)

urlRequestHandler : UrlRequest -> String
urlRequestHandler req = "request"

urlChangeHandler: Url.Url -> String
urlChangeHandler url = "???"

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
          div [class "card", style "width" "23rem", style "margin-top" "20px", style "position" "relative"] [
            img [ src "assets/img/card4.jpg", class "card-img-top"] []
            ,span [id "sender"] [text ("De: " ++ md.config.from)]
            ,span [id "receiver"] [text ("Para: " ++ md.config.to)]

            ,div [class "card-body"] [
              h5 [class "card-title"] [text "Teste"]
              ,p [class "card-text"] [text md.config.question]
              ,div [class "row justify-content-between"] [
                button [id "btWin", class "btn btn-danger", attribute "data-toggle" "modal", attribute "data-target" "#win-modal", attribute "type" "button"] [text md.config.from]
                ,button [id "btFail", class "btn btn-danger", attribute "data-toggle" "modal", attribute "data-target" "#fail-modal", attribute "type" "button"] [text md.config.other]
              ]
            ]
            
            ,Modal.render {
              title = emojiToString 0x1F60D
              ,okText ="OK"
              ,content ="Eu sabia !!! " ++ emojiToString 0x1F618
              ,id = "win-modal"
            }
            
            ,Modal.render {
              title = emojiToString 0x1F603 
              ,okText ="OK"
              ,content ="Deixa de ser besta " ++ emojiToString 0x1F60A
              ,id = "fail-modal"
            }
          ]
        ]
      ]
    ]
  }
    