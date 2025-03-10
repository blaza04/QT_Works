import QtQuick

Window {
    id : win
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello third")
    Rectangle{
        width:100
        height:100
        color:"blue"
        anchors.centerIn:parent
        border.width:2
        border.color:"black"
        MouseArea{
            anchors.fill:parent
            onClicked:{
                // system.setButton(!system.button)
                // system.print
                //system.setButton()
                win.color="grey"
                myClass.myFunction();
            }
        }
    }
}
