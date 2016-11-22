import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml.Models 2.2

Item {

    property var current_res
    property int isVisible:0

    function set_background(back_res) {

        main_screen_background.source = back_res
        set_manager.set_background_name(current_res)
        isVisible = false
    }

    function go_home_screen() {

        isVisible = false
    }

    function preview(text_name) {

        current_res = text_name
        pre_view.source = "file://opt/background/"+current_res
    }

    id:set_screen
    width: root.width
    height: root.height-topbar.height

    Rectangle{

        width: root.width
        height: root.height-topbar.height
        color: "gray"
        opacity: 0.95
        visible: isVisible

        Column{

            spacing: set_screen.width * 0.02
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Row{

                spacing: set_screen.width * 0.02
                /* Image for preview background image */
                Image {

                    width: set_screen.width * 0.5
                    height: set_screen.width * 0.5
                    id: pre_view
                    source: main_screen_background.source
                }

                Rectangle {

                    id: list_rectangle
                    color: "white"; radius: 5
                    width: set_screen.width * 0.25
                    height: set_screen.width * 0.5

                    /* Showing background resouce list*/
                    ListView{

                        id: res_listview
                        x:parent
                        width: set_screen.width * 0.2
                        height: set_screen.width * 0.5
                        clip: true

                        model: ObjectModel{

                            Column {

                                spacing: set_screen.width * 0.015

                                Repeater{

                                    model:set_manager.get_res_cnt()

                                    Text {

                                        id: name
                                        height: set_screen.width * 0.05
                                        text: set_manager.get_res_name(index)

                                        MouseArea{

                                            anchors.fill: name
                                            onClicked: { preview(name.text) }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Row{

                spacing: set_screen.width * 0.015
                anchors.horizontalCenter: parent.horizontalCenter

                Button {

                    id: confirm_btn
                    text: "Confirm"
                    onClicked: { set_background ("file://opt/background/"+current_res) }
                }

                Button {

                    id: home_btn
                    text:"Home"
                    onClicked: { go_home_screen() }
                }
            }
        }
    }
}

