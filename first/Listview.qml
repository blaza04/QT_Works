
import QtQuick
Item {
    anchors.fill:parent
    anchors.margins:10
    ListView{
        id:listview
        width:parent.width/2
        height:parent.height
        model:mymodel
        spacing: 2
        delegate:mydelegate
    }
    ListModel{
        id:mymodel
        ListElement{ name :"Adin" ; age:"20" ; occupation:"engineer"}
        ListElement{ name :"dewin" ; age:"22" ; occupation:"engineer"}
        ListElement{ name :"anurage" ; age:"21" ; occupation:"engineer"}
        ListElement{ name :"deepak" ; age:"20" ; occupation:"engineer"}
        ListElement{ name :"Adin" ; age:"20" ; occupation:"engineer"}
        ListElement{ name :"dewin" ; age:"22" ; occupation:"engineer"}
    }
    Component{
        id:mydelegate
        Rectangle{
            height:80
            width:listview.width
            color:"lightblue"
            border.width:2
            border.color:"black"
            Row{
                anchors.fill:parent
                anchors.margins:10
                spacing:5
                Text{
                    text:name + "," + age
                    color:"black"
                    font.pixelSize:30
                }
                Text{
                    text: occupation
                    color:"black"
                    font.pixelSize:20
                }
            }
        }
    }
}
