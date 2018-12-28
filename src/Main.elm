module Main exposing (main)

import Browser
import Element exposing (Element, alignRight, centerX, el, fill, padding, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import Html exposing (Html)
import Http
import Json.Decode as Decode exposing (field)


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { status : Status
    }


type Status
    = Loading
    | Loaded
    | Failed String


type alias User =
    { id : Int
    , firstName : String
    , lastName : String
    }



-- Init


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { status = Loaded
      }
    , Cmd.none
    )


decodeUsers : Decode.Decoder (List User)
decodeUsers =
    Decode.list decodeUser


decodeUser : Decode.Decoder User
decodeUser =
    Decode.map3 User
        (field "id" Decode.int)
        (field "first_name" Decode.string)
        (field "last_name" Decode.string)



-- View


view : Model -> Browser.Document Msg
view model =
    { title = "Friendsmas present from Jared"
    , body =
        [ viewPage model ]
    }


viewPage : Model -> Html Msg
viewPage model =
    case model.status of
        Loading ->
            Html.text "Loading..."

        Loaded ->
            viewPageSuccess model

        Failed errorMessage ->
            viewError errorMessage


viewPageSuccess model =
    Element.layout [ Element.explain Debug.todo ] <|
        Element.row
            [ width fill
            ]
            [ viewHeading model
            ]


viewHeading model =
    Element.el
        [ Region.heading 1
        , Font.center
        , width fill
        ]
        (text "Friendsmas")


viewError : String -> Html Msg
viewError errorMessage =
    Html.text <| "Error: " ++ errorMessage



-- Update


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


httpErrorToString : Http.Error -> String
httpErrorToString httpError =
    case httpError of
        Http.BadUrl urlError ->
            "Bad url: " ++ urlError

        Http.Timeout ->
            "Timeout"

        Http.NetworkError ->
            "Network error"

        Http.BadStatus httpResponse ->
            "Bad status: " ++ httpResponse.status.message

        Http.BadPayload errorMessage httpResponse ->
            "Bad payload: " ++ errorMessage



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
