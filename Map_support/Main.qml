/*
import QtQuick 2.15
import QtLocation
import QtPositioning
import QtQuick.Controls

Window {
    property variant fromCoordinate       //: QtPositioning.coordinate(59.9483, 10.7695)
    //: QtPositioning.coordinate(59.9645, 10.671)

    property var source: QtPositioning.coordinate(8.54671867722126, 76.87960068638984)
    //Acsia Technologies
    width: 1100
    height: 780
    visible: true
    title: qsTr("Hello World")
    // Component.onCompleted: {
    //     geoService = Qt.createQmlObject("import QtLocation; GeoServiceProvider { }", this);
    //     console.log(geoService);
    // }
    Rectangle {
        id: navigationScreen
        property bool navigationActive : false

        anchors.fill: parent

        Rectangle{
            z:1
            height: 600   //parent.height * 0.3
            width:  300   //parent.width * 0.3
            color:"transparent"
            anchors{
                left:parent.left
                top:parent.top
            }
            TextField{
                id:s_location
                placeholderText: qsTr("serach")
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
                    geocodemodel.update()
                }
                text:"search"
                anchors{
                    top:s_location.bottom
                    margins:10
                }
            }
            Button{
                id:navbtn
                width:parent.width *.9
                height:50
                onClicked: {
                       navigationScreen.navigationActive = true;
                       //map.bearing = currentHeading;  // Adjust the map's orientation
                       map.tilt = 45;
                       navigateAnimation.running=true;// Tilt the map to make it look 3D
                       //startNavigation();
                   }
               // onClicked:{
                 //   console.log("clicked non animation");
                  //  navigateAnimation.running=true;
                    // if(map.toCoordinate !== undefined && map.toCoordinate.isValid){
                    //     marker.coordinate =  map.toCoordinate
                    // } else{
                    //     console.log("eroror with animation")
                    // }
                //}
                text:"navigate"
                anchors{
                    top:findbtn.bottom
                    margins:10
                }
            }

        }
        Plugin {
            id: mapPlugin
            name: "osm"
            PluginParameter{
                name:"osm.mapping.custom.host"
                value: "https://tile.openstreetmap.org/"

            }
        }
        Map {
            id: map

            property var toCoordinate
            property var currentLocation: QtPositioning.coordinate(8.54671867722126, 76.87960068638984)
            property var routePath: []
            GeocodeModel{
                id:geocodemodel
                plugin:mapPlugin
                query: s_location.text
                onLocationsChanged:{
                    let location = get(0).coordinate
                    map.toCoordinate = location
                    map.center = location
                    map.zoomLevel = 14
                    marker1.coordinate = location
                    routemodel.update()

                }
            }
            RouteModel{

                id:routemodel
                plugin:mapPlugin
                query : RouteQuery{
                    waypoints:[
                        map.currentLocation,map.toCoordinate
                    ]
                }
                onStatusChanged:{
                    routePolyline.path = routemodel.get(0).path
                    map.routePath = routemodel.get(0).path
                }

            }
            MapPolyline{
                id:routePolyline
                line.width:5
                line.color:'green'
            }

            PropertyAnimation {
                id: navigateAnimation
                target: marker
                property: "coordinate"
                duration: 100
                easing.type:Easing.InOutQuad

                running: false
                onRunningChanged: {
                    if (!running && map.routePath.length > 0) {
                        marker.coordinate = map.routePath.shift(); // Move to next point
                        navigateAnimation.restart();
                    }
                }
            }
            SequentialAnimation {
                id: movementAnimation
                PropertyAnimation {
                    target: marker
                    property: "coordinate"
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
                PropertyAnimation {
                    target: marker
                    property: "rotation"
                    duration: 500
                    easing.type: Easing.InOutQuad
                }
            }




            plugin: mapPlugin
            visible: true
            anchors.fill: parent
            activeMapType: map.supportedMapTypes[map.supportedMapTypes.length-1]
            center: currentLocation
            zoomLevel: 14
            property geoCoordinate startCentroid


            MapQuickItem {
                id: marker
                coordinate: map.currentLocation
                anchorPoint.x: image.width/4
                anchorPoint.y: image.height

                sourceItem: Image {
                    fillMode:Image.PreserveAspectFit
                    id: image
                    source: "Assets/gps.png"
                    height: 40
                    width: height
                }
                Behavior on coordinate{
                    NumberAnimation{
                        id:animation
                        duration:1000
                        easing.type:Easing.InOutQuad
                    }
                }

                onCoordinateChanged: map.center = marker.coordinate

            }
            MapQuickItem {
                id: marker1
                anchorPoint.x: image.width/4
                anchorPoint.y: image.height
                sourceItem: Image {
                    id: image1
                    source: "Assets/gps.png"
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
    function startNavigation() {
        let steps = 50;  // Number of movement steps
        let delay = 1000; // Delay between each step (ms)

        let deltaLat = (map.toCoordinate.latitude - map.currentLocation.latitude) / steps;
        let deltaLon = (map.toCoordinate.longitude - map.currentLocation.longitude) / steps;

        let index = 0;
        let moveInterval = setInterval(function() {
            if (index >= steps) {
                clearInterval(moveInterval);
                console.log("Navigation complete!");
                return;
            }

            // Update marker's location
            map.currentLocation = QtPositioning.coordinate(
                map.currentLocation.latitude + deltaLat,
                map.currentLocation.longitude + deltaLon
            );
            marker.coordinate = map.currentLocation;

            // Update rotation based on direction
            let angle = Math.atan2(deltaLon, deltaLat) * (180 / Math.PI);
            marker.rotation = angle;

            movementAnimation.restart();  // Restart animation
            index++;
        }, delay);
    }
}

*/


/*
import QtQuick 2.15
import QtLocation
import QtPositioning
import QtQuick.Controls

Window {
    property variant fromCoordinate: QtPositioning.coordinate(59.9483, 10.7695)
    property variant toCoordinate: QtPositioning.coordinate(59.9645, 10.671)
    width: 1100
    height: 780
    visible: true
    title: qsTr("Hello World")

    Rectangle {
        id: navigationScreen
        property variant currentLocation: QtPositioning.coordinate(8.366670, 76.996700) // Example coordinates

        anchors.fill: parent

        Map {
            id: map
            plugin: mapPlugin
            visible: true
            anchors.fill: parent
            activeMapType: map.supportedMapTypes[1]
            center: currentLocation
            zoomLevel: 14
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

            MapQuickItem {
                id: marker
                coordinate: currentLocation
                anchorPoint.x: image.width / 2
                anchorPoint.y: image.height
                sourceItem: Image {
                    id: image
                    source: "Assets/gps.png"
                    height: 40
                    width: 40
                }
            }
        }

        Rectangle {
            z: 1
            height: 100 // Fixed height for the navigation area
            width: parent.width
            color: "transparent"

            TextField {
                id: s_location
                placeholderText: qsTr("Search")
                width: parent.width * 0.9
                height: 50
                anchors {
                    top: parent.top
                    left: parent.left
                    margins: 10
                }
            }

            Button {
                id: findbtn
                text: qsTr("Search")
                width: parent.width * 0.9
                height: 50
                anchors {
                    top: s_location.bottom
                    left: parent.left
                    margins: 10
                }
                onClicked: {
                    console.log("Search button clicked");
                    routeQuery.clearWaypoints();
                    routeQuery.addWaypoint(fromCoordinate);
                    routeQuery.addWaypoint(toCoordinate);
                    routeQuery.travelModes = RouteQuery.CarTravel;
                    routeQuery.routeOptimizations = RouteQuery.FastestRoute;

                    map.center = fromCoordinate;
                    routeModel.update();// Center the map on the start coordinate
                }
            }

            ListView {
                id: routeListView
                interactive: true
                model: ListModel { id: routeInfoModel }
                anchors {
                    top: findbtn.bottom
                    left: parent.left
                    right: parent.right
                    margins: 10
                }
                delegate: Item {
                    width: routeListView.width
                    Text {
                        text: instruction + " - " + distance
                    }
                }
            }
        }

        Plugin {
            id: mapPlugin
            name: "osm"

            PluginParameter{
                name:"osm.mapping.custom.host"
                value: "https://tile.openstreetmap.org/"

            }
        }


        RouteModel {
            id: routeModel
            plugin: map.plugin
            query: RouteQuery {
                id: routeQuery
            }
                onStatusChanged: {
                    if (status === RouteQuery.Ready) {
                        console.log("Route query ready");
                        routeInfoModel.clear(); // Clear previous route info
                        for (var i = 0; i < routeModel.count; i++) {
                            var segment = routeModel.get(i);
                            routeInfoModel.append({
                                instruction: segment.maneuver.instructionText,
                                distance: segment.maneuver.distanceToNextInstruction
                            });
                        }
                    } else if (status === RouteModel.Error) {
                        console.log("Error in route model");
                    }
                }
            }
        }
    }
*/


/*
import QtQuick 2.15
import QtLocation
import QtPositioning
import QtQuick.Controls

Window {
    property variant fromCoordinate


    property var source: QtPositioning.coordinate(8.54671867722126, 76.87960068638984)

    width: 1100
    height: 780
    visible: true
    title: qsTr("Hello World")
    // Component.onCompleted: {
    //     geoService = Qt.createQmlObject("import QtLocation; GeoServiceProvider { }", this);
    //     console.log(geoService);
    // }
    Rectangle {
        id: navigationScreen
        anchors.fill: parent
        Rectangle{
            z:1
            height: 600
            width:  300
            color:"transparent"
            anchors{
                left:parent.left
                top:parent.top
            }
            TextField{
                id:s_location
                placeholderText: qsTr("serach")
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
                    geocodemodel.update()
                    map.tilt = 0
                    navigateAnimation.running=false;
                    map.zoomLevel=10

                }
                text:"search"
                anchors{
                    top:s_location.bottom
                    margins:10
                }
            }
            Button{
                id:navbtn
                width:parent.width *.9
                height:50
                onClicked: {

                    map.tilt = 50;
                    navigateAnimation.running=true;

                    // Tilt the map to make it look 3D

                }
                onDoubleClicked:{
                    navigateAnimation.running=false
                }

                text:"navigate"
                anchors{
                    top:findbtn.bottom
                    margins:10
                }
            }
            Button{
                id:stop
                anchors{
                    top:navbtn.bottom
                }
                width:parent.width *.9
                height:50
                onClicked:{
                    navigateAnimation.running=false
                }
            }

        }
        Plugin {
            id: mapPlugin
            name: "osm"
            PluginParameter{
                name:"osm.mapping.custom.host"
                value: "https://tile.openstreetmap.org/"

            }
        }
        Map {
            id: map

            property var toCoordinate
            property var currentLocation: QtPositioning.coordinate(8.54671867722126, 76.87960068638984)
            property var routePath: []

            GeocodeModel{
                id:geocodemodel
                plugin:mapPlugin
                query: s_location.text
                onLocationsChanged:{
                    let location = get(0).coordinate
                    map.toCoordinate = location
                    map.center = location
                    map.zoomLevel = 14
                    marker1.coordinate = location
                    routemodel.update()

                }
            }
            RouteModel{
                id:routemodel
                plugin:mapPlugin
                query : RouteQuery{
                    waypoints:[
                        map.currentLocation,map.toCoordinate
                    ]

                }
                onStatusChanged:{
                    routePolyline.path = routemodel.get(0).path
                    map.routePath = routemodel.get(0).path

                        // if (routemodel.count > 0) {
                        //     console.log("Route found, updating path...");
                        //     if (map.routePath.length === 0) {
                        //         map.routePath = routemodel.get(0).path;
                        //     }
                        // } else {
                        //     console.log("No route found!");
                        // }
                    }

            }
            MapPolyline{
                id:routePolyline
                line.width:5
                line.color:'green'
            }

            PropertyAnimation {
                id: navigateAnimation
                target: marker
                property: "coordinate"
                duration: 100
                easing {
                    type: Easing.InOutQuad
                }
                running: false
                onRunningChanged: {
                    if (!running && map.routePath.length > 0) {
                        marker.coordinate = map.routePath.shift();
                        navigateAnimation.restart();
                    }
                }
            }

            plugin: mapPlugin
            visible: true
            anchors.fill: parent
            activeMapType: map.supportedMapTypes[map.supportedMapTypes.length-1]
            center: currentLocation
            zoomLevel: 14

            property geoCoordinate startCentroid

            MapQuickItem {
                id: marker
                coordinate: map.currentLocation
                anchorPoint.x: image.width/4
                anchorPoint.y: image.height

                sourceItem: Image {
                    fillMode:Image.PreserveAspectFit
                    id: image
                    source: "Assets/gps.png"
                    height: 40
                    width: height
                }


                onCoordinateChanged:{
                    map.center = marker.coordinate
                    //map.currentLocation=marker.coordinate       /////
                    routemodel.update();
                }
                // onCoordinateChanged: {
                //       map.center = marker.coordinate
                //       let distance = marker.coordinate.distanceTo(map.currentLocation);

                //         map.currentLocation = marker.coordinate;


                //             map.routePath.shift();


                //         routePolyline.path = map.routePath;
                //     }


            }
            MapQuickItem {
                id: marker1
                anchorPoint.x: image.width/4
                anchorPoint.y: image.height
                sourceItem: Image {
                    id: image1
                    source: "Assets/gps.png"
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

*/



import QtQuick 2.15
import QtLocation
import QtPositioning
import QtQuick.Controls
import QtQuick.Layouts
Window {
    width: 1100
    height: 780
    visible: true
    title: qsTr("Hello World")
    Rectangle {
        id: navigationScreen
        anchors.fill: parent
        Rectangle{
            z:1
            height: 600
            width:  500
            color:"transparent"
            anchors{
                left:parent.left
                top:parent.top
            }
            Controls{
                setIcon:"Assets/followme.png"
                id:control
                anchors{
                    margins:10
                }
                onClicked:{
                    map.center=map.currentLocation
                    //map.zoomLevel=18
                    zoomAnimation.restart()
                    console.log("controls clicked")
                }
            }
            Controls{
                id:control1
                anchors{
                    top:control.bottom
                    margins:10
                }
                onClicked:{

                    navForm.visible=!navForm.visible
                }
                setIcon:"Assets/marker_blue.png"
            }
            Controls{
                id:control2
                anchors{
                    top:control1.bottom
                    margins:10
                }
                onClicked:{
                    searchPopup.visible = !searchPopup.visible
                }
                setIcon:"Assets/locationPin.png"
            }

            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<THIS IS THE LOCATION SEARCH POPUP PART<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            Rectangle {
                id:searchPopup
                visible:false
                color: "#F0F0F0" // Replace palette.base
                height:180
                width:250
                radius: 15
                anchors{
                    top:control2.top
                    left:control2.right
                }
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
                        source: "Assets/mapLabel.png"
                        fillMode:Image.PreserveAspectFit
                        Layout.preferredHeight: 30
                        Layout.preferredWidth:30
                    }
                    ColumnLayout {
                        id:columnlayout
                        TextField {
                            id:locationInput
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
                        setIcon:"Assets/Search.svg"
                        textlabel:"Search"

                        iconWidth:100
                        onClicked:{
                            console.log("clicked on new button")
                            //geocodemodel.update();
                            serachLocation(locationInput.text);
                        }
                    }
                }
            }
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<THIS IS THE ROUTING PART UI<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            Rectangle {
                id:navForm
                visible:false
                color: "#F0F0F0" // Replace palette.base
                height:230
                width:250
                radius: 15
                anchors{
                    top:control1.top
                    left:control1.right
                }
                Rectangle {
                    id: topLabel2
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
                            text: qsTr("Search Here")
                            color: "#FFFFFF" // Replace palette.light
                            font.pixelSize: 16
                        }
                    }
                }
                RowLayout {
                    id:rowLayoutSearch1
                    anchors.top: topLabel2.bottom
                    anchors.topMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width
                    Image {
                        source: "Assets/searchIcon.svg"
                        fillMode:Image.PreserveAspectFit
                        Layout.preferredHeight: 100
                    }
                    ColumnLayout {
                        id:columnlayout1
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
                        TextField {
                            placeholderText: qsTr("Choose Destination")
                            color: "#333333"
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
                        top:rowLayoutSearch1.bottom
                        topMargin:5
                    }
                    IconButton{
                        id:btn2
                        setIcon:"Assets/path.png"
                        textlabel:"Find"
                        onClicked:{
                            routemodel.update()
                        }
                    }
                    IconButton{
                        id:btn12
                        setIcon:"Assets/direction.svg"
                        textlabel:"Preview"
                        onClicked:{
                            navigateAnimation.running=true
                            map.tilt=60
                        }
                    }
                    LabelButton{
                        id:btn23
                        setIcon:"Assets/finishline.png"
                    }
                }

            }
        }
        ////>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


        Plugin {
            id: mapPlugin
            name: "osm"
            PluginParameter{
                name:"osm.mapping.custom.host"
                value: "https://tile.openstreetmap.org/"

            }
        }
        Map {
            id: map
            property var toCoordinate
            property var currentLocation: QtPositioning.coordinate(8.54671867722126, 76.87960068638984)
            property var routePath: []

            // GeocodeModel{
            //     id:geocodemodel
            //     plugin:mapPlugin
            //     query: locationInput.text
            //     onLocationsChanged:{
            //         let location = get(0).coordinate         // converted this part ti qt from qml side
            //         map.toCoordinate = location
            //         map.center = location
            //         map.zoomLevel = 14
            //         //marker1.coordinate = location
            //         routemodel.update()

            //     }
            // }

            RouteModel{
                id:routemodel
                plugin:mapPlugin
                query : RouteQuery{
                    waypoints:[
                        nav.CurrentLocation,nav.SearchLocation
                    ]

                }
                //autoUpdate:true
                onStatusChanged:{
                    routePolyline.path = routemodel.get(0).path
                    map.routePath = routemodel.get(0).path
                }

            }
            MapPolyline{
                id:routePolyline
                line.width:5
                line.color:'green'
            }
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<ANIMATIONSSSSSSSS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
            PropertyAnimation {
                id: navigateAnimation
                target: marker
                property: "coordinate"
                duration: 100
                easing.type:Easing.InOutQuad

                running: false
                onRunningChanged: {
                    if (!running && map.routePath.length > 0) {
                        marker.coordinate = map.routePath.shift(); // Move to next point
                        navigateAnimation.restart();
                    }
                }
                onFinished:{
                    map.tilt=0
                }
            }
            NumberAnimation{
                 id:zoomAnimation
                 target:map
                 property: "zoomLevel"
                 //from:map.zoomLevel
                  to:18
                  duration:1500
                  easing.type:Easing.InOutQuad
            }
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
            // SequentialAnimation {
            //     id: movementAnimation
            //     PropertyAnimation {
            //         target: marker
            //         property: "coordinate"
            //         duration: 1000
            //         easing.type: Easing.InOutQuad
            //     }
            //     PropertyAnimation {
            //         target: marker
            //         property: "rotation"
            //         duration: 500
            //         easing.type: Easing.InOutQuad
            //     }
            // }
            plugin: mapPlugin
            visible: true
            anchors.fill: parent
            activeMapType: map.supportedMapTypes[map.supportedMapTypes.length-1]
            center: currentLocation
            zoomLevel: 10
            property geoCoordinate startCentroid


            MapQuickItem {
                id: marker
                coordinate: nav.CurrentLocation
                anchorPoint.x: image.width/4
                anchorPoint.y: image.height

                sourceItem: Image {
                    fillMode:Image.PreserveAspectFit
                    id: image
                    source: "Assets/gps.png"
                    height: 40
                    width: height
                }
                onCoordinateChanged:{
                    map.center = marker.coordinate
                    //map.currentLocation=marker.coordinate       /////
                    //routemodel.update();
                }
            }
            MapQuickItem {
                id: marker1
                anchorPoint.x: image.width/4
                anchorPoint.y: image.height
                coordinate:nav.SearchLocation
                sourceItem: Image {
                    id: image1
                    source: "Assets/gps.png"
                    height: 40
                    width: height
                }
                onCoordinateChanged:{
                    map.center = marker1.coordinate
                    zoomAnimation.restart()

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


