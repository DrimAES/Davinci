import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id: active_page
    width: root.width * 0.15

    function get_current_screen(screen_id){

        var scree_cnt = 5
        for( var i=0; i<scree_cnt ;i++ )
            page_bar.itemAt(i).color = "gray"

        page_bar.itemAt(screen_id).color = "white"
    }

    Row {

        anchors.horizontalCenter: active_page.horizontalCenter
        spacing: root.width * 0.01

        Repeater {

            id: page_bar
            model: 5
            delegate: Rectangle{

                id: current_bar
                width: root.width * 0.012
                height: root.width * 0.012
                radius: 100
                color: if(index == 0) "white" ; else "gray"
            }
        }
    }

    Connections {

        target: root
        onChaned_page: { get_current_screen(id) }
    }
}

