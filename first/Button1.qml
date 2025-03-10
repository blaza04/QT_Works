import QtQuick
import QtQuick.Controls
Item {
    id:myButton
      Rectangle{
        id:rect
        width:parent.width/3
        height:parent.height/3
        anchors.centerIn:parent
        color:"blue"
    }
    Button{
        id:btn
        anchors.horizontalCenter:parent.horizontalCenter
        text:"click"
        anchors{
            topMargin:20
            top:rect.bottom
        }
        onClicked:{
            rect.color="red"
            rect.radius=100
        }
        background:Rectangle{
            width:100
            height:50
            anchors.centerIn:parent
            Image {
                id: myImage
                source: "assets/buttonImage.jpg"
                width:parent.width
                height:parent.height
                fillMode:Image.PreserveAspectFit
            }
        }
    }
}
