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
        [ Background.color (rgb255 76 76 71)
        , Font.color (rgba 0 0 0 0.9)
        , Font.size (scaled 1)
        , Font.family
            [ Font.typeface "Muli"
            , Font.sansSerif
            ]
        , width fill
        ]
    <|
        Element.column
            [ centerX

            -- , spacing 30
            , width (fill |> maximum 1024)
            ]
            [ viewHeading model
            , viewContent model
            ]


viewHeading model =
    Element.el
        [ Region.heading 1
        , Background.color (rgb255 193 73 83)
        , Font.center
        , Font.size (scaled 4)
        , padding 30
        , width fill
        ]
        (text "Friendsmas 2018")


viewContent model =
    Element.column
        [ Background.color (rgb255 229 220 197)
        , padding 30
        , spacing 30
        , width fill
        ]
        [ viewIntro
        , viewMusic model
        ]


viewIntro =
    textColumn
        [ Background.color (rgba 1 1 1 0.9)
        , Border.rounded 5
        , padding 30
        , spacing 30
        , width fill
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
        , Element.paragraph
            [ Font.family
                [ Font.typeface "Charm"
                ]
            ]
            [ text "Jared M. Smith"
            ]
        ]


viewMusic model =
    Element.column
        [ spacing 30
        , width fill
        ]
        [ musicGroupTitle <|
            text "Andrea Wirth and the Dirty Lil' Fun Havers"
        , andreaWirthAndDirtyLilFunHavers
        , musicGroupTitle <|
            text "Big Ninja Delight"
        , bigNinjaDelight
        , musicGroupTitle <|
            text "Calabash"
        , calabash
        , musicGroupTitle <|
            text "Dang Heathens"
        , dangHeathens
        , musicGroupTitle <|
            text "The Queen Exchange"
        , queenExchange
        , musicGroupTitle <|
            text "Suspekt"
        , cicada
        ]


musicGroupTitle title =
    paragraph
        [ Region.heading 3
        , Font.size (scaled 3)
        ]
        [ title ]


viewError : String -> Html Msg
viewError errorMessage =
    Html.text <| "Error: " ++ errorMessage


andreaWirthAndDirtyLilFunHavers =
    embedFull <|
        Html.iframe
            [ attribute "allow" "autoplay"
            , attribute "frameborder" "0"
            , attribute "height" "400"
            , Html.Attributes.src "https://www.iheart.com/artist/andrea-wirth-the-dirty-lil-30077778/?embed=true"
            , attribute "width" "100%"
            ]
            []


bigNinjaDelight =
    embedFull <|
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
    embedFull <|
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
    embedFull <|
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
    embedFull <|
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
    embedFull <|
        Html.iframe
            [ attribute "allow" "autoplay"
            , attribute "frameborder" "no"
            , attribute "height" "450"
            , attribute "scrolling" "no"
            , Html.Attributes.src "https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/playlists/9469341&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true"
            , attribute "width" "100%"
            ]
            []


scaled scalar =
    round <| modular 16 1.25 scalar


embedFull embeddedHtml =
    el
        [ width fill
        ]
    <|
        html embeddedHtml



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
