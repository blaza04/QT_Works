import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Button {
    id: btnCOntrol
    property real radius: 20
    property color backgroundColor: "#14A44D"
    property color smallBackgroundColor: "#14A44D"
    property string setIcon: ""
    property color textColor: "#FFFFFF"
    property real borderWidth: 0
    property color borderColor: "transparent"
    property real iconWidth: 18
    property real iconHeight: 18
    implicitHeight: 45
    implicitWidth: 80
    SystemPalette { id: myPalette; colorGroup: SystemPalette.Active }
    text:"Click"
    contentItem: RowLayout {
        anchors.centerIn: parent
        width: parent.width
        Image {
            id: iconImage
            source: btnCOntrol.setIcon
            width: btnCOntrol.iconWidth
            height: btnCOntrol.iconHeight
        }
            Label {
                color: btnCOntrol.textColor
                font.pixelSize: 14
                text: "Start"
                Layout.alignment:horizontalAlignment
            }
        }
        background: Rectangle {
            implicitHeight: btnCOntrol.implicitHeight
            implicitWidth: btnCOntrol.implicitWidth
            radius: btnCOntrol.radius
            color: btnCOntrol.backgroundColor
            border.width: btnCOntrol.borderWidth
            border.color: btnCOntrol.borderColor
            Behavior on color {
                ColorAnimation {
                    easing.type: Easing.Linear
                    duration: 200
                }
            }
            Rectangle {
                id: indicator
                property int mx
                property int my
                x: mx - width / 2
                y: my - height / 2
                height: width
                radius: btnCOntrol.radius
                color: Qt.lighter(myPalette.highlight)
            }
        }
        MouseArea {
            id: mouseArea
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            onPressed: {
                indicator.mx = mouseX
                indicator.my = mouseY
                main.restart()
            } onReleased:{
                 btnCOntrol.onClicked()
            }
        }

        ParallelAnimation {
            id: main
            NumberAnimation {
                target: indicator
                property: "width"
                from: 0
                to: btnCOntrol.width * 2.5
                duration: 200
            }
            NumberAnimation {
                target: indicator
                property: "opacity"
                from: 0.9
                to: 0
                duration: 200
            }
        }
    }

