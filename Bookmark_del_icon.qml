import QtQuick 2.0
import QtQuick.Controls 1.4


Item {
    property int del_bookmark_id
    property var del_icon_image
    property bool is_run:false

    id: bookmark_del_icon
    width: 58
    height: 59


    Column {

        Image {
            id: bookmark_del_icon_btn
            width: bookmark_del_icon.width
            height: bookmark_del_icon.width
            source: del_icon_image

            MouseArea {
                anchors.fill: bookmark_del_icon_btn
                onClicked: {
                    console.log("[sykang] del_bookmark_btn [" + del_bookmark_id + "]")
                    root.del_bookmark(del_bookmark_id)
                }
            }
        }

        RotationAnimation {

            id: bookmark_delete_btn_animation
            target: bookmark_del_icon_btn
            property: "rotation"

            from: 3
            to  : 357
            duration: 150

            direction: RotationAnimation.Counterclockwise
            easing.type: Easing.InOutElastic
            running: is_run

            onStopped: {
                if(is_run)
                    bookmark_delete_btn_animation.running = true
            }

        }

    }

}
