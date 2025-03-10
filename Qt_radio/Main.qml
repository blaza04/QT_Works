import QtQuick
import QtMultimedia 5.15
Rectangle {
    width: 320
    height: 480

    Radio {
        id: radio
        band: Radio.FM
    }

    MouseArea {
        x: 0; y: 0
        height: parent.height
        width: parent.width / 2

        onClicked: radio.scanDown()
    }

    MouseArea {
        x: parent.width / 2; y: 0
        height: parent.height
        width: parent.width / 2

        onClicked: radio.scanUp()
    }
}
