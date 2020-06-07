module Modal exposing (render)
import Browser
import Html exposing (Html, span, h5, div, button, text, node)
import Html.Attributes exposing (attribute, class, id)

type alias ModalProps = 
  {
    title: String 
    ,okText:String
    ,content:String
    ,id:String
  }


render: ModalProps -> Html msg
render props = 
  div [ class "modal fade", id props.id, attribute "aria-hidden" "true"] [
    div [class "modal-dialog"] [
      div [class "modal-content"] [
        
        div [class "modal-header"] [
          h5 [class "modal-title"] [text props.title]
          ,button [attribute "type" "button", class "close",  attribute "data-dismiss" "modal"] [
            span [attribute "aria-hidden" "true"] [text "X"]
          ]
        ]
        
        ,div [class "modal-body"] [text props.content]
        
        {- ,div [class "modal-footer"] [
          button [attribute "type" "button", class "btn btn-secondary", attribute "data-dismiss" "modal"] [text props.okText]
        ] -}
      ]
    ]
  ]
