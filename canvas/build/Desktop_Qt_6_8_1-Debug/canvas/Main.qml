
import QtQuick

Window {
    width: 920
    height: 480
    visible: true
    title: qsTr("Hello World")

    Canvas{
        id:myCanvas
        width:parent.width
        height:parent.height
        anchors{
            left:parent.left
            top:parent.top
            bottom:parent.bottom
            //centerIn:parent
        }

        visible:false
        property var  center: parent.height
        property var vcenter: parent.width
        onPaint:{
            var a = getContext("2d")

            // a.beginPath()
            // a.lineWidth = 15
            // a.strokeStyle = "red"
            // a.moveTo(10,10)
            // a.lineTo(600,10)
            // a.stroke()
            // a.closePath()
            // ctx.beginPath()
            // ctx.fillStyle = "blue"
            // ctx.fillRect(20,20,100,100)
            // ctx.stroke()
            // ctx.closePath()
            a.beginPath()

            a.fillRect(100,30,50,100)
            a.stroke()
            a.closePath()

            a.beginPath()

            a.lineWidth=20;
            a.strokeStyle ="green"
            a.fillStyle = "blue"
            a.arc(400,200,170,0,6.3,0)  //xcordinate,ycordinate,radius,starting angle,start in radians,end in radianns , clock/couterclock
            a.stroke()
            a.closePath()
        }
    }
    Canvas{
        id:myCanvas2
        width:parent.width
        height:parent.height
        visible:true
        anchors{
            left:parent.right
            top:parent.top
            bottom:parent.bottom
            right:parent.right
            centerIn:parent
        }
        property int val :0

        // NumberAnimation on val{
        //     from : 0
        //     to :270
        //     duration : 1000
        //     loops: Animation.Infinite
        //     running : false
        // }

        Rectangle{
            id:needle
            width:4
            height:parent.height *.3
            color:"red"
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.verticalCenter
            }
           rotation:-150
            transformOrigin : Item.Bottom
            Behavior on rotation{

                SpringAnimation{
                    damping: 1
                    epsilon: .5
                    mass: 4
                    spring: 1
                }
            }
            onRotationChanged: {
                myCanvas2.currentValue = needle.rotation - 150
                myCanvas2.requestPaint()
            }
        }
        Rectangle{
            id:center
            height:10
            width:10
            radius:width/2
            color:"black"
            anchors{
                centerIn:parent
                verticalCenter : parent.verticalCenter

                horizontalCenter : parent.horizontalCenter
            }
        }
        property real centerWidth: width / 2
        property real centerHeight: height / 2

        property real radius: Math.min(myCanvas2.width, myCanvas2.height) / 2

        property real minimumValue: -360
        property real maximumValue: 0
        property real currentValue: -360

        property real angle:  (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI + 0.01
        property real angleOffset: 20.955
        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, myCanvas2.width, myCanvas2.height);
            ctx.beginPath();
            ctx.lineWidth = 50;
            ctx.strokeStyle = ((myCanvas2.val > 200)? "#ED1C24" : "#6da1fc")
            ctx.fillStyle = ((myCanvas2.val > 200)? "#ED1C24" : "#3ef705")
            ctx.shadowBlur = 4.47
            ctx.shadowOffsetX = 5.45

            // to set the initial fill position

            // Syntax

            // Param                       Description
            //     x                       The x-coordinate of the center of the circle
            //     y                       The y-coordinate of the center of the circle
            //     r                       The radius of the circle
            //     sAngle                  The starting angle, in radians (0 is at the 3 o'clock position of the arc's circle)
            //     eAngle                  The ending angle, in radians
            //     counterclockwise        Optional. Specifies whether the drawing should be counterclockwise or clockwise.
            //     False is default, and indicates clockwise, while true indicates counter-clockwise.
            //     context.arc(x, y, r, sAngle, eAngle, counterclockwise)

            ctx.arc(myCanvas2.centerWidth, myCanvas2.centerHeight, myCanvas2.radius - (ctx.lineWidth / 2) - 75, myCanvas2.angleOffset, myCanvas2.angleOffset + myCanvas2.angle);
            //ctx.arc(200,200,100,20,5,0)
            ctx.fillRect(200,20,angle*100,20)
            ctx.stroke();


                //Rotation of the needle is updated here

        }
        antialiasing:true
        smooth:true
        focus: true

        onValChanged:{
            console.log(val)
            needle.rotation = (-149 + val)
        }

        Keys.onPressed: {
            if (event.key === Qt.Key_Space && !event.isAutoRepeat) {
                myCanvas2.val =  300

            }
        }
        Keys.onReleased: {
            if (event.key === Qt.Key_Space && !event.isAutoRepeat) {
                myCanvas2.val = 0
            }}

    }
}



/*

import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Canvas")

    color : "#898588"
    Canvas{
        id:mCanvas
        width: parent.width;
        height: parent.height
        anchors.centerIn : parent
        visible : false

        onPaint:{

            var ctx = getContext("2d")
            ctx.beginPath()
            ctx.lineWidth = 5
            ctx.strokeStyle = "red"
             // Reference - https://www.w3schools.com/tags/ref_canvas.asp

              // moveTo(x,y)                      - tells the canvas to move the pointer/painter to the specified point
              // lineTo(x,y)                      - Draw line from x to y
              // stroke()                         - Draws the current path
              // clearRect(x, y, width, height)   -Clears specified pixels within a rectangle
              // rect(x, y, width, height)        -Adds a rectangle to the path
              // fillRect(x, y, width, height)    -Draws a "filled" rectangle



            ctx.moveTo(20, 20)
            ctx.lineTo(600, 20)
            ctx.stroke()
            ctx.closePath()

            ctx.beginPath()
            ctx.fillStyle = "green"
            ctx.fillRect(50,50,200,250)
            ctx.stroke()
            ctx.closePath()

            ctx.beginPath()
            ctx.strokeStyle = "blue"
            ctx.arc(400,150,100,0,Math.PI,1)
            ctx.stroke()
            ctx.closePath()

        }

    }

    Canvas{

        id:mCanvas1

        width: parent.width;
        height: parent.height
        anchors.centerIn : parent
        visible : true
        property int val: 0
        // NumberAnimation on val{
        //     from : 0
        //     to :270
        //     duration : 2000
        //     loops: Animation.Infinite
        //     running : false
        // }
        Rectangle{
            id:needle
            width : 4
            height : parent.width / 3.9
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.verticalCenter
            }
            rotation : -149
            transformOrigin : Item.Bottom
            color : "Black"
            antialiasing: true
            smooth: true
            Behavior on rotation{

                SpringAnimation{
                    damping: 1
                    epsilon: .5
                    mass: 4
                    spring: 1
                }
            }


            onRotationChanged: {
                mCanvas1.currentValue = needle.rotation - 211
                mCanvas1.requestPaint()
            }

            Rectangle{
                id: centerPoint
                width : 20
                height : 20
                radius : width / 2
                color : "Red"

                anchors{
                    verticalCenter : parent.verticalCenter
                    verticalCenterOffset : 80
                    horizontalCenter : parent.horizontalCenter
                }

            }
        }
        Text{
            id: speedoText
            text : Math.round(149 + needle.rotation)

            font.pixelSize : 50
            anchors{
                horizontalCenter: parent.horizontalCenter
                verticalCenter : parent.verticalCenter
                verticalCenterOffset : 35
            }
        }


        antialiasing: true
        smooth: true



        property color secondaryCol: needle.color
        property real centerWidth: width / 2
        property real centerHeight: height / 2

        property real radius: Math.min(mCanvas1.width, mCanvas1.height) / 2

        property real minimumValue: -360
        property real maximumValue: 0
        property real currentValue: -360

        property real angle: (currentValue - minimumValue) / (maximumValue - minimumValue) * 2 * Math.PI + 0.01
        property real angleOffset: 20.955 // to set the initial fill position

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, mCanvas1.width, mCanvas1.height);
            ctx.beginPath();
            ctx.lineWidth = 25;
            ctx.strokeStyle = ((mCanvas1.val > 200)? "#ED1C24" : "#CEDEF8")
            ctx.shadowBlur = 4.47
            ctx.shadowOffsetX = 5.45

            ctx.arc(mCanvas1.centerWidth, mCanvas1.centerHeight, mCanvas1.radius - (ctx.lineWidth / 2) - 75, mCanvas1.angleOffset, mCanvas1.angleOffset + mCanvas1.angle);
            ctx.stroke();

        }

        focus: true


           // Rotation of the needle is updated here

        onValChanged:{
            console.log(val)
            needle.rotation = (-149 + val)
        }

        Keys.onPressed: {
            if (event.key === Qt.Key_Space && !event.isAutoRepeat) {
                mCanvas1.val =  300

            }
        }
        Keys.onReleased: {
            if (event.key === Qt.Key_Space && !event.isAutoRepeat) {
                mCanvas1.val = 0
            }}

    }

}

*/
