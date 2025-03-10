import QtQuick

Item {
    id:root
    Rectangle{
        id:main
        width:root.width/2
        height:root.height/2
        color:"blue"
        border.width:5
        border.color:"green"
        anchors{
            right:root.right
            bottom:root.bottom
        }
        Text{
            id:myText
            text:"My Text"
            font.pixelSize:10
            anchors{
              centerIn:parent
            }
        }
        radius:100
        Image {
            id: image
            source: "assets/deadpool.png"
            width:root.width/3
            height:root.width/3
            anchors{
                right:root.right
            }
            MouseArea{
                anchors.fill:root
                onClicked:{
                    myText.color="green"
                    myText.font.pixelSize=30
                    myText.text="HELLO"
                }
            }
        }
    }
    Row{
        width:root.width/2
        height:root.height
        spacing:5
        Rectangle{
            width:root.width/2
            height:root.height
            color:"blue"
        }
        Rectangle{
            width:root.width/2
            height:root.height
            color:"green"
        }
    }
    Column{
        width:root.width/2
        height:root.width/4
        spacing:2
        anchors{
            right:root.right
            horizontalCenter:root.horizontalCenter
        }
        Rectangle{
            width:root.width
            height:root.height/2
            color:"blue"
        }
        Rectangle{
            width:root.width
            height:root.height/2
            color:"green"
        }
    }
}
