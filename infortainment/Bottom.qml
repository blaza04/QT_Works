import QtQuick
Rectangle{
    id:bottomSide
    anchors{
        bottom : parent.bottom
        left:parent.left
        right:parent.right
    }
    color : "black"
    height:parent.height/15
    Image{
        id:carIcon
        source:"Assets/caricc.png"
        anchors{
            left:parent.left
            top:parent.top
            bottom:parent.bottom
        }
        fillMode:Image.PreserveAspectFit
    }
    Controllers{
        id:driverControllerOne
        anchors{
            top:parent.top
            bottom:parent.bottom
            left:carIcon.right
            leftMargin:100
        }
        temp : driver
    }
    Controllers{
        id:passengerControllerOne
        anchors{
            top:parent.top
            bottom:parent.bottom
            right:audioControl.left
            rightMargin:150
        }
        temp : passenger
    }
    AudioControl{
        id:audioControl
        anchors{
            rightMargin:100
            verticalCenter:parent.verticalCenter
            right:parent.right
        }
        ctl : audiohandle
    }

}

