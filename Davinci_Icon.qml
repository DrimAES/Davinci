import QtQuick 2.5
import QtQuick.Controls 1.4

Item {
    property string     icon_name
    property var        icon_id
    property bool       active_timer:false
    property bool       isclicked:false
    property bool       delete_btn_visible:false

    signal add_bookmark(var app_name)
    signal delete_icon()


    function cancel_delete(){

        active_timer = false
        app_delete_btn.visible = false
    }

    function set_icon_invisible(){

        main_icon.visible = false
    }

    function checking_delete_animation() {

        if(active_timer == true)
            app_delete_btn_animation.running = true
    }

    function checking_isclicked() {

        if(isclicked != true)
        {
            app_delete_btn.visible = true
            app_delete_btn_animation.running = true
            active_timer = true
        }
    }

    function delete_application() {

        app_manager.delete_app(icon_name)
        delete_icon()
        active_timer = false
    }

    function click_application() {

        if(!root.isbookmarked)
        {
            if(active_timer !== true)
            {
                isclicked = true
                /* bookmark mode */
                console.log(icon_name)
                app_manager.start_app(icon_name)
            }
        }

        else
        {
            /* disable active timer, when clicked app icon at bookmark mode */
            active_timer = false
            isclicked = true

            /* no bookmark mode */
            add_bookmark(icon_name)
            root.isbookmarked = false
            console.log("Emit add_bookmark signal")
        }

    }

    function start_timer() {

        isclicked = false;
        ono_second_timer.running = true
    }

    id: main_icon
    width: root.width * 0.09
    height: main_icon.width + 30

    FontLoader {
        id: font_load
        source: "file://opt/res/Arial_Black.ttf"
    }

    Column {

        Image{

            id: app_icon
            width: main_icon.width
            height: main_icon.width
            source: app_manager.get_res_file(icon_name)

            MouseArea {

                anchors.fill: app_icon
                onClicked: { click_application() }
                onPressed: { start_timer() }
            }
        }

        Text {

            id: app_name
            width: main_icon.width
            text: icon_name
            font.family: font_load.name
            color: "#ffffff"
            font.pointSize: root.width * 0.013
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Davinci_delete_btn{

        id: app_delete_btn
        visible: delete_btn_visible

        onRequest_delete: { delete_application() }

    }

    RotationAnimation {

        id: app_delete_btn_animation
        target: app_delete_btn
        property: "rotation"

        from: 3
        to  : 357
        duration: 150

        direction: RotationAnimation.Counterclockwise
        easing.type: Easing.InOutElastic
        onStopped: { checking_delete_animation() }

    }

    Timer {

        id: ono_second_timer
        interval: 1000
        running: false
        repeat: false
        onTriggered: { checking_isclicked() }
    }
}

