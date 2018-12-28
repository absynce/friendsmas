module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Region as Region
import Html exposing (Html)
import Html.Attributes exposing (attribute)
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
    Element.layout
        [ Element.explain Debug.todo
        , width fill
        ]
    <|
        Element.column
            [ width (fill |> maximum 1024)
            , centerX
            ]
            [ viewHeading model
            , viewContent model
            ]


viewHeading model =
    Element.el
        [ Region.heading 1
        , Font.center
        , width fill
        ]
        (text "Friendsmas 2018")


viewContent model =
    Element.column
        [ Element.explain Debug.todo
        ]
        [ Element.paragraph []
            [ text "Thanks, for being a friend!"
            ]
        , Element.paragraph []
            [ text "In addition to the physical thrift finds, you are treated to the following Evansville area music found online."
            ]
        , Element.paragraph []
            [ text "Your friend,"
            ]
        , Element.paragraph []
            [ text "Jared"
            ]
        , viewMusic model
        ]


viewMusic model =
    Element.column
        [ Element.explain Debug.todo
        , width fill
        ]
        [ el [ Region.heading 3 ] <|
            text "Andrea Wirth and the Dirty Lil' Fun Havers"
        , andreaWirthAndDirtyLilFunHavers
        , el [ Region.heading 3 ] <|
            text "Big Ninja Delight"
        , bigNinjaDelight
        , el [ Region.heading 3 ] <|
            text "Calabash"
        , calabash
        , el [ Region.heading 3 ] <|
            text "Dang Heathens"
        , dangHeathens
        , el [ Region.heading 3 ] <|
            text "The Queen Exchange"
        , queenExchange
        , el [ Region.heading 3 ] <|
            text "Suspekt"
        , cicada
        ]


viewError : String -> Html Msg
viewError errorMessage =
    Html.text <| "Error: " ++ errorMessage


andreaWirthAndDirtyLilFunHavers =
    html <|
        Html.iframe
            [ attribute "allow" "autoplay"
            , attribute "frameborder" "0"
            , attribute "height" "400"
            , Html.Attributes.src "https://www.iheart.com/artist/andrea-wirth-the-dirty-lil-30077778/?embed=true"
            , attribute "width" "100%"
            ]
            []


bigNinjaDelight =
    html <|
        Html.iframe
            [ attribute "allow" "autoplay"
            , attribute "frameborder" "no"
            , attribute "height" "450"
            , attribute "scrolling" "no"
            , Html.Attributes.src "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/488101206&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true"
            , attribute "width" "100%"
            ]
            []


calabash =
    html <|
        Html.iframe
            [ attribute "allow" "autoplay"
            , attribute "frameborder" "no"
            , attribute "height" "450"
            , attribute "scrolling" "no"
            , Html.Attributes.src "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/116034337&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true"
            , attribute "width" "100%"
            ]
            []


cicada =
    html <|
        Html.iframe
            [ attribute "allow" "autoplay"
            , attribute "frameborder" "no"
            , attribute "height" "166"
            , attribute "scrolling" "no"
            , Html.Attributes.src "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/145253471%3Fsecret_token%3Ds-Ek7mG&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true"
            , attribute "width" "100%"
            ]
            []


dangHeathens =
    html <|
        Html.iframe
            [ attribute "frameborder" "no"
            , attribute "height" "265"
            , attribute "scrolling" "no"
            , Html.Attributes.src "https://www.reverbnation.com/widget_code/html_widget/artist_2445122?widget_id=55&pwc[included_songs]=1&context_type=page_object&pwc[size]=small"
            , attribute "style" "width:0px;min-width:100%;max-width:100%;"
            , attribute "width" "100%"
            ]
            []


queenExchange =
    html <|
        Html.iframe
            [ attribute "allow" "autoplay"
            , attribute "frameborder" "no"
            , attribute "height" "450"
            , attribute "scrolling" "no"
            , Html.Attributes.src "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/9469341&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true"
            , attribute "width" "100%"
            ]
            []



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
