import QtQuick
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Qt modelview")

    // RowLayout{
    //     id:rowLayout
    //     Repeater{
    //         model:15
    //         clip:true
    //         Rectangle{
    //             height:100
    //             width:100
    //             color:"blue"
    //         }
    //     }
    // }

    ListView{
        id:newList
        model:listModel
        delegate:mydelegate
        height:parent.height
        width:parent.width
        spacing : 2
        //header:myHeader
        footer:myFooter
    }
    Component{
        id:mydelegate
        Rectangle{
            id:delegateRectangle
            width:newList.width
            height:newList.height * .10
            color:newList.currentIndex == index ? "grey" : "lightblue"
            Text{
                id:listText
                text:name
                font.pixelSize:20
            }
            MouseArea{
                id:clicker
                anchors.fill:parent
                onClicked:{
                    newList.currentIndex=index
                }
            }
        }
    }
    ListModel{
        id:listModel
        ListElement{name:"item1"}
        ListElement{name:"item2"}
        ListElement{name:"item3"}
        ListElement{name:"item4"}
        ListElement{name:"item5"}
        ListElement{name:"item6"}
        ListElement{name:"item7"}
        ListElement{name:"item8"}
    }
    Component{
        id:myFooter
        Text{
            text:"footer"
            font.pixelSize:20
        }
    }
}

