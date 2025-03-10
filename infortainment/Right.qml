import QtQuick
import QtLocation 6.8
import QtPositioning 6.8

Rectangle{
    id : rightSide
    color:"green"
    anchors{
        bottom:botttomSide.top
        right:parent.right
        top:parent.top
    }
    width : parent.width * 0.70


    Plugin{
        id: mapPlugin
        name: "osm"
    }

    Map{
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(8.52,76.93) // tvm
        zoomLevel: 14
        property geoCoordinate startCentroid

        PinchHandler {
            id: pinch
            target: null
            onActiveChanged: if (active) {
                                 map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
                             }
            onScaleChanged: (delta) => {
                                map.zoomLevel += Math.log2(delta)
                                map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                            }
            onRotationChanged: (delta) => {
                                   map.bearing -= delta
                                   map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                               }
            grabPermissions: PointerHandler.TakeOverForbidden
        }
        WheelHandler {
            id: wheel
            // workaround for QTBUG-87646 / QTBUG-112394 / QTBUG-112432:
            // Magic Mouse pretends to be a trackpad but doesn't work with PinchHandler
            // and we don't yet distinguish mice and trackpads on Wayland either
            acceptedDevices: Qt.platform.pluginName === "cocoa" || Qt.platform.pluginName === "wayland"
                             ? PointerDevice.Mouse | PointerDevice.TouchPad
                             : PointerDevice.Mouse
            rotationScale: 1/120
            property: "zoomLevel"
        }
        DragHandler {
            id: drag
            target: null
            onTranslationChanged: (delta) => map.pan(-delta.x, -delta.y)
        }
        Shortcut {
            enabled: map.zoomLevel < map.maximumZoomLevel
            sequence: StandardKey.ZoomIn
            onActivated: map.zoomLevel = Math.round(map.zoomLevel + 1)
        }
        Shortcut {
            enabled: map.zoomLevel > map.minimumZoomLevel
            sequence: StandardKey.ZoomOut
            onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
        }
    }
    Image {
        id: lockImage
        source:handle.lock ? "Assets/lock.png" : "Assets/un.png"
        anchors{
            left:parent.left
            top:parent.top
            margins:5
        }
        fillMode: Image.PreserveAspectFit
        MouseArea{
            id : mouse
            anchors.fill : parent
            onClicked:{
                handle.setLock(!handle.lock)
            }
        }

    }
    Text{
        id:timeText
        text: handle.currentTime
        font.pixelSize:15
        anchors{
            left:lockImage.right
            top:parent.top
            margins:5
            topMargin:10
            leftMargin:10
        }
    }
    Image{
        id:profile
        source:"Assets/person.png"
        anchors{
            left : timeText.right
            top:parent.top
            leftMargin:30
            margins:5
        }
        fillMode:Image.PreserveAspectFit
    }
    Text{
        id:profileText
        text:handle.profile
        font.pixelSize:15
        anchors{
            left:profile.right
            top:parent.top
            margins:5
            leftMargin:10
            topMargin:10
        }
    }
    Rectangle{
        id:serachBox
        radius:5
        anchors{
            left:lockImage.left
            top:lockImage.bottom
            topMargin:5
        }
        color:"#edf2ef"
        width:parent.width * 1/3
        height:parent.height * 1/12
        Image{
            id:serachIcon
            source:"Assets/search.png"
            anchors{
                left:parent.left
                verticalCenter:parent.verticalCenter
                leftMargin:10
            }
            fillMode:Image.PreserveAspectFit
            height:parent.height *.5
        }
        Text{
            id:searchText
            visible:searchInput.text == ""
            text:"Navigate"
            color:"black"
            anchors{
                left:serachIcon.right
                verticalCenter:parent.verticalCenter
            }
            height:parent.height *.5
        }
        TextInput{
            id:searchInput
            clip:true
            anchors{
                left:serachIcon.left
                right:parent.right
                top:parent.top
                bottom:parent.bottom
                leftMargin:20
            }
            verticalAlignment:Text.AlignVCenter
        }
    }
}
