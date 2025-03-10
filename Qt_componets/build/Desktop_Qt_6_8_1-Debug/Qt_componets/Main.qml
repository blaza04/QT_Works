import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Rectangle {
        width: 300; height: 200
        Component {
            id: contactDelegate
            Item {
                width: grid.cellWidth; height: grid.cellHeight
                Column {
                    anchors.fill: parent
                    Image { source: portrait; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: name; anchors.horizontalCenter: parent.horizontalCenter }
                }
            }
        }

        GridView {
            id: grid
            anchors.fill: parent
            cellWidth: 80; cellHeight: 80

            model: contactmodel
            delegate: contactDelegate
            highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            focus: true
        }
    }

    ListModel {
        id:contactmodel
        ListElement {
            name: "Jim Williams"
            portrait: "pics/portrait.png"
        }
        ListElement {
            name: "John Brown"
            portrait: "pics/portrait.png"
        }
        ListElement {
            name: "Bill Smyth"
            portrait: "pics/portrait.png"
        }
        ListElement {
            name: "Sam Wise"
            portrait: "pics/portrait.png"
        }
    }
}

