import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    property string bookmark_icon_name:"Add Icon"
    property string icon_image:"file://opt/res/add_bookmark.png"
    property int    bookmark_id

    function click_bookmarked_app() {

        /* If not added bookmark */
        if(isSet[bookmark_id] === 0)
        {
            bookmark.visible = false
            bookmark_delete_page.visible = false
            list_screen.visible = true
            active_bar.visible = true

            /* set bookmark mode */
            root.isbookmarked = 1
            bookmark_page.clicked_index = bookmark_id
        }

        /* If added bookmark */
        else
        {
            /* run application */
            app_manager.start_app(bookmark_icon_name)
        }
    }

    id: bookmark_icon
    width: bookmark_page.width * 0.13
    height: bookmark_icon.width + 30

    Column {

        Image {

            id: bookmark_btn
            width: bookmark_icon.width
            height: bookmark_icon.width
            source: icon_image

            MouseArea {

                anchors.fill: bookmark_btn
                onClicked: { click_bookmarked_app() }
            }
        }

        Text {
            id: icon_txt
            width: bookmark_icon.width
            text: bookmark_icon_name
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: root.width * 0.015
            color: "black"
        }
    }


}

