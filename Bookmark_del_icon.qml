import QtQuick 2.0
import QtQuick.Controls 1.4


Item {
    property int del_bookmark_id
    property var del_icon_image

    id: bookmark_del_icon
    width: bookmark_delete_page.width * 0.13
    height: bookmark_del_icon.width + 30

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

    }

}
