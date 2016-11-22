import QtQuick 2.0
import QtQuick.Controls 1.4

Item {

    property var isSet:[0,0,0,0,0]
    property var bookmark_appname_list:["NULL","NULL","NULL","NULL","NULL"]
    property int isDuplicate
    property var clicked_index
    property int isLoadBookmarkConfig:0
    
    function set_bookmark_btn(app_name) {

        bookmark.visible = true
        list_screen.visible = false
        active_bar.visible = false

        bookmark_delete_page.visible = false
	isDuplicate = 0

	//check bookmark duplication
	for(var i=0; i<5; i++)
	{
		console.log(bookmark_appname_list[i])
		//duplicate
		if( bookmark_appname_list[i] == app_name)
		{
		    console.log("[sykang] duplication")
		    isDuplicate = 1
		    console.log(isDuplicate)

		}
	}

	if(isDuplicate == 0)
	{
		bookmark_items.itemAt(clicked_index).icon_image = app_manager.get_res_file(app_name)
		bookmark_items.itemAt(clicked_index).bookmark_icon_name = app_name
		bookmark_appname_list[clicked_index] = app_name

		isSet[clicked_index] = 1
	}
    }

    id:bookmark_page

    width: root.width * 0.85
    height: root.height * 0.65
    opacity: 0.87
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: bookmark_page_rec
        width: bookmark_page.width
        height: bookmark_page.height
        radius: 20
        color: "white"
        anchors.horizontalCenter: parent.horizontalCenter

        Row {
            spacing: bookmark_page.width * 0.04
            anchors.centerIn: parent
            Repeater {
                /* Maximum bookmark count is 5 */
                id:bookmark_items
                model: 5
                delegate: Bookmark_icon{
                    bookmark_id: index
                }
            }

        }
    }
    Connections {
        target: root
        onSet_bookmark:{ set_bookmark_btn(app_name) }

        onDel_bookmark:
        {
            console.log("[sykang] function delBookmark : [" + del_bookmark_index + "]")

            /* If exist bookmark */
            if( isSet[del_bookmark_index] == 1 )
            {
                bookmark_items.itemAt(del_bookmark_index).icon_image = "file:///opt/res/add_bookmark.png"
                bookmark_items.itemAt(del_bookmark_index).bookmark_icon_name = "Add Icon"
                set_manager.del_bookmark_name(del_bookmark_index);

                isSet[del_bookmark_index] = 0
            }
            bookmark.visible = true
            list_screen.visible = false
            active_bar.visible = false
            bookmark_delete_page.visible = false
        }
        onLoad_bookmark:
        {
            if( isLoadBookmarkConfig == 0 )
            {
                console.log("[sykang] function onLoad_bookmark first")

                for(var i=0; i<5; i++)
                {
                    if( set_manager.get_bookmark_name(i) != "NULL")
                    {
                        bookmark_items.itemAt(i).icon_image = "file://opt/res/" + set_manager.get_bookmark_name(i) + ".png"
                        bookmark_items.itemAt(i).bookmark_icon_name = set_manager.get_bookmark_name(i)
                        isSet[i] = 1
                    }
                }

                isLoadBookmarkConfig = 1
            }
            else
                console.log("[sykang] function onLoad_bookmark")
        }
    }

    Row{
        spacing: 5
        //anchors.horizontalCenter: parent.horizontalCenter
        anchors.right: parent.right
        // confirm button & Home Button

        Image {
            id: delete_home_btn
            width: bookmark_page.width * 0.05
            height: bookmark_page.width * 0.05
            source: "file://opt/res/home.png"
            //text:"Home"
            MouseArea {
                anchors.fill: delete_home_btn
                onClicked: {
                    bookmark.visible = false
                    list_screen.visible = true
                }
            }
        }

        Image {
            id: delete_btn
            width: bookmark_page.width * 0.05
            height: bookmark_page.width * 0.05
            source: "file://opt/res/delete.jpeg"
            MouseArea {
                anchors.fill: delete_btn
                onClicked: {
                    bookmark_delete_page.visible = true
                    list_screen.visible = false
                    active_bar.visible = false
                }
            }
        }
    }
}

