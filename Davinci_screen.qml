import QtQuick 2.0
import QtQuick.Controls 1.4

/* screen object */
Item {

    signal send_bookmark(var app_name)
    signal refresh_screens(var screen_id)

    property int screen_id

    function refresh_screen() {

        var i=0;
        for(i=0; i<app_manager.get_app_cnt(screen_id);i++)
            icon_repeter.itemAt(i).icon_name = app_manager.get_app_name(screen_id, i)

        if(app_manager.get_app_cnt(screen_id) !== 8)
             icon_repeter.itemAt(i).set_icon_invisible()
    }


    function cancel_delete(){

        var i=0;
        for(i=0;i<app_manager.get_app_cnt(screen_id);i++)
            icon_repeter.itemAt(i).cancel_delete()
    }

    id: screen
    width: parent.width
    height: parent.height

    Rectangle {
        id:screen_sub_img
        width: screen.width * 0.9
        height: screen.height * 0.8
        anchors.centerIn: parent
        color: "#3fffffff"
        radius: 5
    }


    MouseArea {

        anchors.fill: screen
        onClicked: { cancel_delete() }
    }

    Grid {
        id:screen_grid
        width:screen_sub_img.width * 0.8
        height: screen_sub_img.height * 0.9
        x:180
        y:120
        rows:2
        columns: 4
        spacing: (parent.width) * 0.1



        Repeater {

            id : icon_repeter
            width:screen_sub_img.width * 0.7
            height: screen_sub_img.height * 0.8


            /* have to get item count fromm c++ class */
            model: app_manager.get_app_cnt(screen_id)

            Davinci_Icon {

                id: icon_item
                icon_id: index
                icon_name: app_manager.get_app_name(screen_id, index)
                onAdd_bookmark: { send_bookmark(app_name) }
                onDelete_icon:  { refresh_screens(screen_id) }
            }
        }
    }


}

