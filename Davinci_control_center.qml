import QtQuick 2.0
import QtQuick.Controls 1.4

Image {

    property int is_show
    id:control_center_view
    width: 575
    height: 118
    source: "qrc:/res/bg_control.png"


    PropertyAnimation {

        id: hied_control_center_animation;
        target: control_center_view;
        property: "y"
        to: root.height-40
        duration: 1000
        easing.type: Easing.InOutElastic;
        easing.amplitude: 2.0
        easing.period: 1.5
    }

    PropertyAnimation {

        id: show_control_center_animation;
        target: control_center_view;
        to: root.height-control_center.height
        easing.type: Easing.InOutElastic;
        easing.amplitude: 2.0
        easing.period: 1.5
        property: "y"
        duration: 1000
    }

    Column {

        width: control_center_view.width
        height: control_center_view.height

        Rectangle {
            id: hide_control_btn_bg
            width: control_center_view.width
            height: 40
            color: "#00ffffff"

            Image {
                id: hide_control_btn
                width: 22
                height: 14
                y:10
                source: "qrc:/res/control_handle.png"
                anchors.horizontalCenter: parent.horizontalCenter
            }


            MouseArea{

                anchors.fill: hide_control_btn_bg
                onClicked: {
                    // active control center page
                    if(is_show) {
                        console.log("hide")
                        hied_control_center_animation.running = true
                        is_show = false
                    }

                    else {

                        console.log("show")
                        show_control_center_animation.running = true
                        is_show = true
                    }
                }
            }
        }

        Rectangle {
            width: control_center_view.width
            height: 68
            color: "#00ffffff"

            Image {

                id: auto_brightness_on_bg
                width: 64
                height: 64
                source: "qrc:/res/bg_btn_normal.png"
                x:40


                Image {
                    id:auto_brightness_on
                    width: 31
                    height: 31
                    source: "qrc:/res/ic_brightness_auto.png"
                    anchors.centerIn: auto_brightness_on_bg
                }

                MouseArea {

                    anchors.fill: auto_brightness_on_bg
                    onClicked: {
                        auto_brightness_off_bg.visible = true
                        auto_brightness_on_bg.visible = false
                        con_cen_manager.start_auto_brightness()
                    }
                }
            }

            Image {

                id: auto_brightness_off_bg
                width: 64
                height: 64
                source: "qrc:/res/bg_btn_normal.png"
                visible: false
                x:40



                Image {
                    id:auto_brightness_off
                    width: 31
                    height: 31
                    source: "qrc:/res/ic_brightness.png"
                    anchors.centerIn: auto_brightness_off_bg
                }

                MouseArea {

                    anchors.fill: auto_brightness_off_bg
                    onClicked: {
                        auto_brightness_off_bg.visible = false
                        auto_brightness_on_bg.visible = true
                        con_cen_manager.stop_auto_brightness()
                    }
                }
            }

            Slider {

                id:  screen_backlight_slider
                width: 400
                activeFocusOnPress: false
                x:130
                y:20

                maximumValue: 110
                minimumValue: 10

                value: 110
                onValueChanged: { back_manager.change_backlight(value/10) }

            }
        }
    }
}

