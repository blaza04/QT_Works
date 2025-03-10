
import QtQuick 2.15
import QtQuick.Controls

Button {
    property string setIcon: ""
    id: control
    implicitHeight: 80
    implicitWidth: 80
    background: Rectangle {
        anchors.fill: parent
        radius: 15
        color: "#252525"
        border.color: "#FFFFFF"
        border.width: 1
        Behavior on color {
            ColorAnimation {
                duration: 200
                easing.type: Easing.Linear
            }
        }
        // Icon inside the button
        Image {
            id: iconImage
            anchors.centerIn: parent
            width: parent.width * 0.6
            height: parent.height * 0.6
            source: control.setIcon
            fillMode: Image.PreserveAspectFit
            visible: source !== ""
            scale: control.pressed ? 0.8 : 1.0
            Behavior on scale { NumberAnimation { duration: 200 } }
        }
        // Glow Effect Indicator
        Rectangle {
            id: indicator
            property int mx
            property int my
            x: mx - width / 2
            y: my - height / 2
            height: width
            radius: width / 2
            opacity: 0
            color: "#3CDDC6"
            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: {
            indicator.mx = mouseX
            indicator.my = mouseY
            indicator.opacity = 0.8
            anim.restart()
        }
        onReleased: {
            //to trigger the button onclicked beacuse of mousearea
            control.clicked()
        }
    }

    ParallelAnimation {
        id: anim
        NumberAnimation {
            target: indicator
            property: 'width'
            from: 0
            to: control.height * 1.1
            duration: 200
        }
        NumberAnimation {
            target: indicator
            property: 'opacity'
            from: 0.8
            to: 0
            duration: 200
        }
    }
}
