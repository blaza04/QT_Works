import QtQuick 2.15
import QtLocation
import QtPositioning
import QtQuick.Controls

Window {
    width: 1100
    height: 780
    visible: true
    title: qsTr("Hello World")
    TextField{
        placeholderText: qsTr("Enter name")
        width:parent.width
        height:parent.height

    }
    Rectangle {
        id: navigationScreen
        property variant currentLocation: QtPositioning.coordinate(8.54671867722126, 76.87960068638984) //Acsia Technologies

        anchors.fill: parent

        Rectangle{
            z:1
            height: 300   //parent.height * 0.3
            width:  300   //parent.width * 0.3
            color:"grey"
            anchors{
                left:parent.left
                top:parent.top
            }
            TextField{
                id:s_location
                placeholderText: qsTr("Enter name")
                width:parent.width * 0.9
                height:50
                anchors{
                    margins:10
                }
            }
            Button{
                id:findbtn
                width:parent.width *.9
                height:50
                onClicked:{
                    console.log("clicked");
                }
                anchors{
                    bottom:s_location.bottom
                    margins:10
                }
            }

        }
        Plugin {
            id: mapPlugin
            name: "osm"
            // PluginParameter {
            //     name: "osm.mapping.providersrepository.address"
            //     value: "http://maps-redirect.qt.io/osm/5.6/"
            // }
        }

        Map {
            id: map
            plugin: mapPlugin
            visible: true
            anchors.fill: parent
            activeMapType: map.supportedMapTypes[1]
            center: currentLocation
            zoomLevel: 14
            property geoCoordinate startCentroid

            MapQuickItem {
                id: marker

                coordinate: currentLocation
                anchorPoint.x: image.width/4
                anchorPoint.y: image.height

                sourceItem: Image {
                    id: image
                    source: "../../../ui/assets/gps.png"
                    height: 40
                    width: height
                }
            }

            PinchHandler {
                id: pinch
                target: null
                onActiveChanged: if (active)
                                 {
                                     map.startCentroid = map.toCoordinate(pinch.centroid.position, false)
                                 }
                onScaleChanged: (delta) =>
                                {
                                    map.zoomLevel += Math.log2(delta)
                                    map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                                }
                onRotationChanged: (delta) =>
                                   {
                                       map.bearing -= delta
                                       map.alignCoordinateToPoint(map.startCentroid, pinch.centroid.position)
                                   }
                grabPermissions: PointerHandler.TakeOverForbidden
            }

            WheelHandler {
                id: wheel
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
                onActivated: map.zoomLevel = Math.round(onlineMap.zoomLevel + 1)
            }

            Shortcut {
                enabled: map.zoomLevel > map.minimumZoomLevel
                sequence: StandardKey.ZoomOut
                onActivated: map.zoomLevel = Math.round(map.zoomLevel - 1)
            }
        }


    }

}
