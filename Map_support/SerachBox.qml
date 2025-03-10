// import QtQuick
// import QtQuick.Controls
// import QtQuick.Layouts

// Rectangle {
//     id: searchPopup
//     width: 300
//     height: 150
//     radius: 10
//     color: "#333"
//     visible: false  // Initially hidden
//     z: 1  // Below the button
//     Column {
//         anchors.centerIn: parent
//         spacing: 10
//         Text {
//             text: "Enter Location"
//             color: "white"
//             font.pixelSize: 16
//         }

//         TextField {
//             id: locationInput
//             width: 200
//             placeholderText: "Search location..."
//             color: "black"
//             background: Rectangle {
//                 color: "white"
//                 radius: 5
//             }
//         }

//         Button {
//             id:btn_search
//             text: "Search"
//             onClicked: {
//                 console.log("Searching for: " + locationInput.text)
//                 geocodemodel.update()
//             }
//         }
//     }
// }
import QtQuick 2.0
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    color: "#F0F0F0" // Replace palette.base
    height:230
    width:250
    radius: 15
    Rectangle {
        id: topLabel
        width: parent.width
        height: 50
        radius: 15
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        color: "#333333" // Replace palette.dark
        RowLayout {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            Image {
                source: "Assets/Search.svg"
                fillMode:Image.PreserveAspectFit
                Layout.preferredHeight:20
            }
            Label {
                text: qsTr("Search Location")
                color: "#FFFFFF" // Replace palette.light
                font.pixelSize: 16
            }
        }
    }
    RowLayout {
        id:rowLayoutSearch
        anchors.top: topLabel.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        Image {
            source: "Assets/locationPin.svg"
            fillMode:Image.PreserveAspectFit
            Layout.preferredHeight: 30
            Layout.preferredWidth:30
        }
        ColumnLayout {
            id:columnlayout
            TextField {
                placeholderText: qsTr("Choose source")
                color: "#333333" // Replace palette.dark
                font.pixelSize: 16
                Layout.preferredHeight: 50
                Layout.preferredWidth:200
                background: Rectangle {
                    color: "#D3D3D3" // Replace Style.grayColor
                    radius: 8
                }
            }
        }
    }
    RowLayout{
        anchors{
            top:rowLayoutSearch.bottom
            topMargin:5
        }
        IconButton{
            id:btn1
            setIcon:"Assets/direction.svg"
            textlabel:"Search"
            iconWidth:100
        }
    }

}
