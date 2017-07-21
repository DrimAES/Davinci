import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml.Models 2.2
import Qt.labs.folderlistmodel 2.1
import QtGraphicalEffects 1.0

Item {

    property var current_res:-1
    property int isVisible:0
    property int tmp_index:-1

    function set_background(back_res) {

        main_screen_background.source = back_res
        set_manager.set_background_name(current_res)

        list_screen.visible = true
        active_bar.visible = true
        control_center.visible = true
        bookmark_btn_bg.visible = true
        setting_screen_btn_bg.visible = true

        isVisible = false
    }

    function go_home_screen() {

        list_screen.visible = true
        active_bar.visible = true
        control_center.visible = true
        bookmark_btn_bg.visible = true
        setting_screen_btn_bg.visible = true

        isVisible = false
    }

    function preview(text_name) {

        current_res = text_name
        pre_view.source = "file://opt/background/"+current_res
    }

    id:set_screen
    width: root.width
    height: root.height
    visible: isVisible


    // get music list at "file://opt/background" forder

    ListModel {
        id:background_list_model
    }

    Component {
        id:background_list_delegate
        Rectangle {
            id:background_list
            width: res_listview.width
            height: res_listview.height * 0.3
            color: list_color

            Rectangle {
                width: background_list.width
                height: 1
                y:background_list.height
                color: "#c9a0a0"
            }

            Image {
                id:small_preview_img
                source: small_preview_src
                width: 60
                height: 60
                x:20
                y:19
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: small_preview_mask
                }
            }

            Text {
                id:background_list_txt
                text:list_txt
                x:90
                y:35
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
                        background_list_model.insert(tmp_index,{"list_txt":set_manager.get_res_name(tmp_index),"list_color":"#00000000","small_preview_src":"file://opt/background/"+set_manager.get_res_name(tmp_index)})
                    }
                    tmp_index = index
                }
            }
        }
    }

    Rectangle{

        width: root.width
        height: root.height
        color: "#8f000000"
    }

    // Wallparer Setting page title
    Row {
        x:80
        y:80
        width: 195
        spacing: 7
        Image {
            id:setting_img
            width: 33
            height: 31
            source: "qrc:/res/ic_settings.png"
        }

        Text {
            id:wallpaper_txt
            width: 150
            height: 31
            text: "Wallpaper Setting"
            font.family: font_load.name
            font.pointSize: 18
            color: "white"
        }
    }

    Rectangle {
        id:wallpaper_txt_line
        height: 2
        width: 285
        color: "#2fffffff"
        x:80
        y:120
    }

    Column{

        spacing: set_screen.width * 0.02
        anchors.horizontalCenter: parent.horizontalCenter
        y:130

        Row{

            spacing: 10
            /* Image for preview background image */
            Image {

                width: 563
                height: 360
                id: pre_view
                source: main_screen_background.source
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: preview_mask
                }
            }

            Rectangle {
                id: listview_sub
                width: set_screen.width * 0.3
                height: 360
                color: "white"
                radius: 8

                /* Showing background resouce list*/
                ListView{

                    id: res_listview
                    x:parent
                    width: set_screen.width * 0.3
                    height: 350
                    clip: true

                    model: background_list_model
                    delegate: background_list_delegate

                }
            }
        }

        Row{

            spacing: set_screen.width * 0.015
            anchors.right: parent.right


            Image {
                id: confirm_btn_bg
                width: 64
                height: 64
                source: "qrc:/res/bg_btn_normal.png"

                Image {
                    id:confirm_btn
                    width: 31
                    height: 31
                    source: "qrc:/res/ic_confirm.png"
                    anchors.centerIn: confirm_btn_bg
                }

                MouseArea {
                    anchors.fill: confirm_btn_bg
                     onClicked: {
                         if(current_res!=-1)
                            set_background ("file://opt/background/"+current_res)
                          else
                             go_home_screen()
                     }
                }
            }


            Image {
                id: home_btn_bg
                width: 64
                height: 64
                source: "qrc:/res/bg_btn_normal.png"

                Image {
                    id:home_btn
                    width: 31
                    height: 31
                    source: "qrc:/res/ic_home.png"
                    anchors.centerIn: home_btn_bg
                }

                MouseArea {
                    anchors.fill: home_btn_bg
                    onClicked: {
                        go_home_screen()
                    }
                }
            }
        }
    }

    Rectangle {
        id:preview_mask
        width: 563
        height: 360
        radius: 8
        visible: false
    }

    Rectangle {
        id:small_preview_mask
        width: 60
        height: 60
        radius: 5
        visible: false
    }

    Connections {
        target: root
        onBackground_set: {
            var i=0;
            for(i=0;i<set_manager.get_res_cnt();i++)
                background_list_model.append({"list_txt":set_manager.get_res_name(i),"list_color":"#00000000", "small_preview_src":"file://opt/background/"+set_manager.get_res_name(i)})

        }
    }

    FontLoader {
        id: font_load
        source: "res/Arial_Black.ttf"
    }
}

