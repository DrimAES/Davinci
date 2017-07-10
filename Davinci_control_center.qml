import QtQuick 2.0
import QtQuick.Controls 1.4

Rectangle {

    property int is_show

    id:control_center_view
    width: root.width * 0.7
    height: root.height * 0.4
    opacity: 0.93
    color: "#4d4d4d"


    PropertyAnimation {

        id: hied_control_center_animation;
        target: control_center_view;
        property: "y"
        to: root.height+control_center_view.height
        duration: 1000
        easing.type: Easing.InOutElastic;
        easing.amplitude: 2.0
        easing.period: 1.5
    }

    Column {

        width: control_center_view.width
        height: control_center_view.height
        spacing: 30

        Image {

            id: hide_control_btn
            width: root.width * 0.08
            height: root.width * 0.02
            source: "res/hide_set.png"
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea{

                anchors.fill: hide_control_btn
                onClicked: {
                    hied_control_center_animation.running = true
                    show_control_btn.visible = true
                    hide_control_btn.visible = is_show
                }
            }
        }

        Rectangle {

            width: control_center_view.width-70
            height: root.width * 0.08
            color: "white"
            opacity: 0.93
            radius: root.width * 0.005
            anchors.horizontalCenter: parent.horizontalCenter

            Row {

                spacing: root.width * 0.01
                x:root.width * 0.005
                anchors.verticalCenter: parent.verticalCenter

                Image {

                    id: auto_brightness_on
                    source: "file://opt/res/auto_britness_on.png"
                    width: root.width * 0.05
                    height: root.width * 0.05

                    MouseArea {

                        anchors.fill: auto_brightness_on
                        onClicked: {
                            auto_brightness_off.visible = true
                            auto_brightness_on.visible = false
                            con_cen_manager.start_auto_brightness()
                        }
                    }
                }

                Image {

                    id: auto_brightness_off
                    source: "file://opt/res/auto_britness_off.png"
                    width: root.width * 0.05
                    height: root.width * 0.05
                    visible: false

                    MouseArea {

                        anchors.fill: auto_brightness_off
                        onClicked: {
                            auto_brightness_off.visible = false
                            auto_brightness_on.visible = true
                            con_cen_manager.stop_auto_brightness()
                        }
                    }
                }
            }
        }

        Slider {

            id:  screen_backlight_slider
            width: control_center_view.width-root.width * 0.07
            activeFocusOnPress: false
            anchors.horizontalCenter: parent.horizontalCenter

            maximumValue: 110
            minimumValue: 10

            value: 110
            onValueChanged: { back_manager.change_backlight(value/10) }
        }
    }
}

