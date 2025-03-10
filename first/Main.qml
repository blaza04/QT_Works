import QtQuick
import QtLocation
import QtPositioning

Window {
    width: 500
    height: 500
    visible: true
    title: qsTr("Hello World")

    // Rectangle{
    //     height:200
    //     width:200
    //     anchors.centerIn:parent
    //     border.width:2
    //     border.color:"black"
    //     //color:clicker.setButton?"red" : "black"

    //     MouseArea{
    //         anchors.fill : parent
    //         onClicked:{
    //             clicker.setButton=true
    //         }
    //     }

    //}

    // Button1{
    //     id:myButton
    //     anchors.fill:parent
    // }
    Listview{
        anchors.bottom:parent.bottom
    }
    // States{
    //     id:myStates
    // }
}
