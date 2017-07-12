import QtQuick 2.4
import QtQuick.Window 2.2
import QtQml.Models 2.2
import QtQuick.Controls 1.4

Window {

    signal chaned_page(var id)
    signal set_bookmark(var app_name)
    signal del_bookmark(int del_bookmark_index)
    signal load_bookmark()
    signal background_set(var i)

    property int isbookmarked

    property var is_set_back_res:0


    function refresh_all_screen() {

        app_manager.refresh_dir()

        screen_1.refresh_screen()
        screen_2.refresh_screen()
        screen_3.refresh_screen()
        screen_4.refresh_screen()
        screen_5.refresh_screen()
    }

    function get_visible(s_id) {

        if( app_manager.get_screen_cnt() / s_id >= 1 )
            return true

        else
            return false
    }

    function show_control_center() {

        control_center.visible = true

        control_center.x = (root.width/2) - (control_center.width)/2
        control_center.y = root.height + control_center.height

        show_control_center_animation.running = true

        show_control_btn.visible = false
        control_center.is_show = true
    }

    function show_setting_page() {

        setting_screen_page_animation.running = true
        setting_screen_page.isVisible = true
    }

    function show_bookmark_page() {

        bookmark.visible = true
        list_screen.visible = false
        active_bar.visible = false
        //load_bookmark()
    }

    id: root
    /* use Screen for using any screen size */
    width: Screen.width
    height: Screen.height
    visible: true


    FontLoader {
        id: font_load
        source: "res/Arial_Black.ttf"
    }

    BorderImage {

        id: main_screen_background
        source: "file://opt/background/"+set_manager.get_background_name()
        width: root.width
        height: root.height
    }

    Rectangle {

        id: topbar
        width: root.width
        height: root.width*0.05
        color: "#3d3d3d"

        Timer {

            interval: 500; running: true; repeat: true
            onTriggered: { time.text = time_manager.get_time() }
        }

        Text {

            id: time
            color: "#ffffff"
            font.family: font_load.name
            font.pointSize: root.width * 0.013
            x: root.width-time.width-15
            y: topbar.height/2
            anchors.verticalCenter: topbar.verticalCenter
        }
    }

    ListView {

        id: list_screen
        width: root.width
        height: root.height
        orientation: ListView.Horizontal
        highlightMoveDuration: 50
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        currentIndex: 0

        onCurrentIndexChanged: { chaned_page(currentIndex) }

        model:ObjectModel {

             Davinci_screen{

                 id:screen_1
                 width: list_screen.width
                 height: list_screen.height
                 screen_id: 0

                 onSend_bookmark:   { set_bookmark(app_name) }
                 onRefresh_screens: { refresh_all_screen() }
             }


             Davinci_screen{

                 id:screen_2
                 width: list_screen.width
                 height: list_screen.height
                 screen_id: 1

                 onSend_bookmark:   { set_bookmark(app_name) }
                 onRefresh_screens: { refresh_all_screen() }
             }


             Davinci_screen{

                 id:screen_3
                 width: list_screen.width
                 height: list_screen.height
                 screen_id: 2

                 onSend_bookmark:   { set_bookmark(app_name) }
                 onRefresh_screens: { refresh_all_screen() }
             }

             Davinci_screen{

                 id:screen_4
                 width: list_screen.width
                 height: list_screen.height
                 screen_id: 3

                 onSend_bookmark:   { set_bookmark(app_name) }
                 onRefresh_screens: { refresh_all_screen() }
             }

             Davinci_screen{

                 id:screen_5
                 width: list_screen.width
                 height: list_screen.height
                 screen_id: 4

                 onSend_bookmark:   { set_bookmark(app_name) }
                 onRefresh_screens: { refresh_all_screen() }
             }
        }
    } /* End ListView */


    Active_page_bar{

        id: active_bar
        y:show_control_btn.y-(root.height/7)
        x:root.width/2-active_bar.width/2
    }

    Davinci_bookmark {

        id: bookmark
        y:root.height/2-bookmark.height/2
        visible: false
    }

    Davinci_bookmark_delete {
        id: bookmark_delete_page
        y:root.height/2-bookmark_delete_page.height/2
        visible: false
    }

    Davinci_control_center{

        x:(root.width/2)-(control_center.width)/2
        y:root.height+control_center.height
        id: control_center
        visible: false
        is_show: 0
    }

    PropertyAnimation {

        id: show_control_center_animation;
        target: control_center;
        to: root.height-control_center.height
        easing.type: Easing.InOutElastic;
        easing.amplitude: 2.0
        easing.period: 1.5
        property: "y"
        duration: 1000
    }

    Image{

        id: show_control_btn
        y: root.height - show_control_btn.height
        width: root.width * 0.08
        height: root.width * 0.02
        source: "res/show_set.png"
        anchors.horizontalCenter: parent.horizontalCenter

        MouseArea {
            anchors.fill: show_control_btn
            onClicked: { show_control_center() }
        }
    }

    NumberAnimation {

        id: setting_screen_page_animation
        target: setting_screen_page;
        property: "opacity"
        from:0.0
        to: 0.95
        duration: 200
    }

    Image {

        id: setting_screen_btn
        width: root.width * 0.05
        height: root.width * 0.05
        y:root.height-setting_screen_btn.height
        //source: "file:./res/setting_btn.png"
        source: "file://opt/res/setting_btn.png"

        MouseArea {
            anchors.fill: setting_screen_btn
            onClicked: {
                console.log("set back")
                if(is_set_back_res==0)
                {
                    background_set(1)
                    is_set_back_res=1
                }
                show_setting_page()
            }
        }
    }

    Image {

        id: bookmark_btn
        width: root.width * 0.05
        height: root.width * 0.05
        x:setting_screen_btn.x + setting_screen_btn.width
        y:root.height-bookmark_btn.height
        source: "file://opt/res/set_bookmark.png"

        MouseArea {
            anchors.fill: bookmark_btn
            onClicked: { show_bookmark_page(); load_bookmark() }
        }
    }

    Setting_screen{

        id: setting_screen_page
        //y:topbar.height
    }
}

