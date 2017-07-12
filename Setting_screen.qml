import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml.Models 2.2
import Qt.labs.folderlistmodel 2.1

Item {

    property var current_res
    property int isVisible:0
    property int tmp_index:-1

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
    height: root.height


    // get music list at "file://opt/background" forder

    ListModel {
        id:background_list_model
    }

    Component {
        id:background_list_delegate
        Rectangle {
            id:background_list
            width: res_listview.width
            height: res_listview.height * 0.15
            color: list_color

            Text {
                id:background_list_txt
                text:list_txt
                x:10
                y:20
                font.pointSize:15
            }

            MouseArea {
                anchors.fill:background_list
                onClicked: {
                    preview(list_txt)
                    list_color="#5ff5b041"

                    if(tmp_index !== -1)
                    {
                        background_list_model.remove(tmp_index)
                        background_list_model.insert(tmp_index,{"list_txt":set_manager.get_res_name(tmp_index),"list_color":"#00000000"})
                    }
                    tmp_index = index
                }
            }
        }
    }

    Rectangle{

        width: root.width
        height: root.height
        color: "gray"
        opacity: 0.95
        visible: isVisible

        Column{

            spacing: set_screen.width * 0.02
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Row{

                spacing: set_screen.width * 0.02

                Rectangle {
                    id:back_sub_img
                    width: set_screen.width * 0.45
                    height: set_screen.width * 0.45
                    color: "#6fffffff"

                    /* Image for preview background image */
                    Image {

                        width: set_screen.width * 0.42
                        height: set_screen.width * 0.42
                        id: pre_view
                        source: main_screen_background.source
                        anchors.verticalCenter: back_sub_img.verticalCenter
                        anchors.horizontalCenter: back_sub_img.horizontalCenter
                    }
                }



                Rectangle {

                    id: list_rectangle
                    color: "#6fffffff"
                    width: set_screen.width * 0.3
                    height: set_screen.width * 0.45

                    /* Showing background resouce list*/
                    ListView{

                        id: res_listview
                        x:parent
                        width: set_screen.width * 0.3
                        height: set_screen.width * 0.45
                        clip: true

                        model: background_list_model
                        delegate: background_list_delegate

                    }
                }
            }

            Row{

                spacing: set_screen.width * 0.015
                anchors.horizontalCenter: parent.horizontalCenter

                Button {

                    id: confirm_btn
                    text: "Confirm"
                    width: 120
                    height: 50
                    onClicked: { set_background ("file://opt/background/"+current_res) }
                }

                Button {

                    id: home_btn
                    text:"Home"
                    width: 120
                    height: 50
                    onClicked: { go_home_screen() }
                }
            }
        }
    }

    Connections {
        target: root
        onBackground_set: {
            var i=0;
            for(i=0;i<set_manager.get_res_cnt();i++)
                background_list_model.append({"list_txt":set_manager.get_res_name(i),"list_color":"#00000000"})

        }
    }
}

