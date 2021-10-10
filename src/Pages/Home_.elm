module Pages.Home_ exposing (Model, Msg, color, page)

import Color
import Element as E exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as I
import Gen.Params.Home_ exposing (Params)
import Page
import Request
import Shared
import Svg as S
import Svg.Attributes as SA
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page _ _ =
    Page.sandbox
        { init = init
        , update = update
        , view = view
        }



-- INIT


type alias Model =
    Float


init : Model
init =
    0



-- UPDATE


type Msg
    = AdjustValue Float


update : Msg -> Model -> Model
update msg _ =
    case msg of
        AdjustValue value ->
            value



-- VIEW


view : Model -> View Msg
view model =
    { title = "Home"
    , element =
        E.el
            [ E.width E.fill
            , E.height E.fill
            , Background.color <| color model
            ]
        <|
            E.column
                [ E.centerX
                , E.centerY
                , E.spacing 100
                ]
                [ E.el
                    [ Font.size 48
                    , E.centerX
                    , Font.family
                        [ Font.external
                            { name = "PT Sans"
                            , url = "https://fonts.googleapis.com/css?family=PT+Sans"
                            }
                        , Font.sansSerif
                        ]
                    ]
                  <|
                    E.text "How do you feel?"
                , E.el [ E.width <| E.px 400, E.centerX ] <|
                    face model
                , slider model
                ]
    }


color : Float -> E.Color
color model =
    let
        hue =
            model * 0.4

        { red, green, blue, alpha } =
            Color.hsl hue 0.3 0.7
                |> Color.toRgba
    in
    E.rgba red green blue alpha


slider : Float -> Element Msg
slider model =
    let
        height =
            26
    in
    I.slider
        [ E.height <| E.px height
        , E.width <| E.px 400
        , E.centerX
        , E.behindContent
            (E.el
                [ E.width E.fill
                , E.height <| E.px 4
                , E.centerY
                , Background.color black
                , Border.rounded 2
                ]
                E.none
            )
        ]
        { onChange = AdjustValue
        , label =
            I.labelHidden "Slider value"
        , min = 0
        , max = 1
        , step = Just 0.01
        , value = model
        , thumb =
            I.thumb
                [ E.width <| E.px height
                , E.height <| E.px height
                , Border.rounded 4
                , Background.color white
                , Border.color black
                , Border.width 4
                ]
        }


white : E.Color
white =
    E.rgb 1 1 1


black : E.Color
black =
    E.rgb 0 0 0


face : Float -> Element msg
face model =
    let
        edgesY =
            40.0

        middleY =
            30.0 + model * 20.0
    in
    E.html <|
        S.svg
            [ SA.width "100%"
            , SA.viewBox "0 0 100 50"
            ]
            [ S.circle
                [ SA.cx "20"
                , SA.cy "20"
                , SA.r "5"
                ]
                []
            , S.circle
                [ SA.cx "80"
                , SA.cy "20"
                , SA.r "5"
                ]
                []
            , S.path
                [ SA.stroke "black"
                , SA.strokeWidth "1"
                , SA.fill "none"
                , SA.d <|
                    "M 40 "
                        ++ String.fromFloat edgesY
                        ++ " Q 50 "
                        ++ String.fromFloat middleY
                        ++ " 60 "
                        ++ String.fromFloat edgesY
                ]
                []
            ]
