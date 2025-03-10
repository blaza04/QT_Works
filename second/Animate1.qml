import QtQuick
import QtQuick.Controls

Item {
    id : animate
    anchors.fill : parent
    Rectangle{
        //radius:200
        id : rect
        width:100
        height:100
        color:system.setButton? "blue" : "green"
        anchors.top:myImage.bottom

        PropertyAnimation{
            id : width
            target:rect
            properties:"width"
            to:1000
            duration : 1000
        }
        MouseArea{
            anchors.fill:parent
            id : newMouse
            onClicked :{
                system.setButton(!system.button)
            }
        }
    }
    Image {
        id: myImage
        x:0
        source: "assets/200.jpg"
        width:parent.width/2
        height:parent.height/2
        rotation:0
        fillMode:Image.PreserveAspectFit
        NumberAnimation on x{
            id:animation1
            duration :5000
            from : 0
            to:900
            running:false
        }
        NumberAnimation on y{
            id:animation3
            duration :5000
            to:0
            running:false
        }
        RotationAnimation on rotation{
            duration:6000
            to : 3600000
            running : false
            id:animation2
            //easing {type: Easing.OutBack;// overshoot: 500
            //}
        }
        NumberAnimation on y{
            duration :1000
            to:200
            running:false
            easing {type: Easing.OutBack; overshoot: 500}
        }
        MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                cursorShape: Qt.BusyCursor
                onClicked:{
                    myImage.x=0
                    myImage.y=0
                    myImage.rotation=0
                    animation1.running=false
                    animation2.running=false
                    animation3.running=false
                }
            }
    }
    Button{
        text:"click"
        anchors.horizontalCenter:parent.horizontalCenter

        onClicked:{
              animation1.running=true
              animation2.running=true
              animation3.running=true
              coloranim.start()

        }
    }

}

