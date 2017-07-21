import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    id:bookmark_delete_page
    width: root.width * 0.85
    height: root.height * 0.65

    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: rec
        width: bookmark_delete_page.width-17
        height: bookmark_delete_page.height-4
        radius: 27
        color: "#7fffffff"
        anchors.horizontalCenter: parent.horizontalCenter

        Row {
            x:75
            y:135
            spacing: 85
            Repeater {
                id:bookmark_delete_items
                model: 5
                delegate: Bookmark_del_icon{
                    del_bookmark_id: index
                }
            }

        }

        onVisibleChanged: {
            if( visible == true )
            {
                for(var i=0; i<5; i++)
                {
                    if( bookmark.isSet[i] == 1 )
                    {
                        console.log("[sykang] iSet[" + i + "] = 1")
                        bookmark_delete_items.itemAt(i).del_icon_image = "qrc:/res/btn_delete.png"
                        bookmark_delete_items.itemAt(i).is_run = true
                    }
                    else
                    {
                        console.log("[sykang] iSet[" + i + "] = 0")
                        bookmark_delete_items.itemAt(i).del_icon_image = "file:/opt/res/invisible.png"
                    }
                }
            }
            else
            {
                console.log("[sykang] not visible")
            }
        }

    }
}

