import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    signal request_delete()

    function show_delete_btn() {

        request_delete()
        delete_app_form.visible = false
    }

    id: delete_app_form
    width: root.width * 0.04
    height: root.width * 0.04

    Row {

        Image {

            id: delete_app
            width: root.width * 0.04
            height: root.width * 0.04
            source: "file://opt/res/delete_app.png"

            MouseArea {

                anchors.fill: delete_app
                onClicked: { show_delete_btn() }
            }
        }
    }
}
