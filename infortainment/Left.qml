import QtQuick

Rectangle{
    id:leftSide
    color:"white"
    anchors{
        bottom : botttomSide.top
        left : parent.left
        right : rightSide.left
        top : parent.top
    }
    Image {
        id: carImage
        source: "Assets/newcar.jpg"
        anchors{
            left:parent.left
            right:parent.right
            top:parent.top
            bottom:parent.bottom
        }
        fillMode:Image.PreserveAspectFit
    }
}
