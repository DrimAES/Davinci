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
        color: "#6f000000"

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
        y:520
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
        y:root.height-40
        id: control_center
        visible: true
        is_show: 0
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

        id: setting_screen_btn_bg
        width: 64
        height: 64
        x:20
        y:root.height-setting_screen_btn_bg.height-15
        source: "qrc:/res/bg_btn_normal.png"

        Image {
            id:setting_screen_btn
            width: 31
            height: 31
            source: "qrc:/res/ic_settings.png"
            anchors.centerIn: setting_screen_btn_bg
        }

        MouseArea {
            anchors.fill: setting_screen_btn_bg
            onClicked: {
                console.log("set back")
                if(is_set_back_res==0)
                {
                    background_set(1)
                    is_set_back_res=1
                }

                list_screen.visible = false
                active_bar.visible = false
                control_center.visible = false
                bookmark_btn_bg.visible = false
                setting_screen_btn_bg.visible = false

                show_setting_page()

            }
        }
    }

    Image {

        id: bookmark_btn_bg
        width: 64
        height: 64
        x:setting_screen_btn_bg.x + setting_screen_btn_bg.width+15
        y:root.height-bookmark_btn_bg.height-15
        source: "qrc:/res/bg_btn_normal.png"

        Image {
            id:bookmark_bt
            width: 31
            height: 31
            source: "qrc:/res/ic_bookmark.png"
            anchors.centerIn: bookmark_btn_bg
        }
        MouseArea {
            anchors.fill: bookmark_btn_bg
            onClicked: { show_bookmark_page(); load_bookmark() }
        }
    }

    Setting_screen{

        id: setting_screen_page
        //y:topbar.height
    }

    Timer {
        id:check_is_running
        interval: 5
        running: false
        repeat: true
        onTriggered: {

            console.log("Check application is running")
            var run_flag = app_manager.check_is_running()

            // if not running app now
            if(run_flag>2)
            {
                // run at main page
                if(run_flag === 3)
                {
                    list_screen.visible = true
                    check_is_running.running = false

                }

                // run at bookmark
                else if(run_flag === 4)
                {
                    bookmark.visible  = true
                    check_is_running.running = false
                }
            }
        }
    }

}

