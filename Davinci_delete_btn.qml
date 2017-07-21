import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    signal request_delete()

    function show_delete_btn() {

        request_delete()
        delete_app_form.visible = false
    }

    id: delete_app_form
    width: 54
    height: 55

    Row {

        Image {

            id: delete_app
            width: delete_app_form.width
            height: delete_app_form.height
            source: "qrc:/res/btn_delete.png"

            MouseArea {

                anchors.fill: delete_app
                onClicked: { show_delete_btn() }
            }
        }
    }
}
