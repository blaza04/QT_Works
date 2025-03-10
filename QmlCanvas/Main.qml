import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Canvas")

    color : "#898588"

    /*
    What is Canvas ?

        The fundamental idea of the canvas element is to render paths using a context 2D object.
        The context 2D object, contains the necessary graphics functions, whereas the canvas acts as the drawing canvas.
        The 2D context supports strokes, fills gradients, text and a different set of path creation commands.

    */

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
            /*
              Reference - https://www.w3schools.com/tags/ref_canvas.asp

              moveTo(x,y)                      - tells the canvas to move the pointer/painter to the specified point
              lineTo(x,y)                      - Draw line from x to y
              stroke()                         - Draws the current path
              clearRect(x, y, width, height)   -Clears specified pixels within a rectangle
              rect(x, y, width, height)        -Adds a rectangle to the path
              fillRect(x, y, width, height)    -Draws a "filled" rectangle

            */

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

        /*
            canvas width and hight , you need to a place to draw thing
            on the sreen right ?
        */
        width: parent.width;
        height: parent.height
        anchors.centerIn : parent

        visible : true

        /*
            Assume this is just a varible that controls the needle
            and the canvas rendering
        */
        property int val: 0

        /*
            This as the name suggests it runs an animation/interpolation on the val
            variable in an interval of 2s
        */

        NumberAnimation on val{
            from : 0
            to :270
            duration : 2000
            loops: Animation.Infinite
            running : false

        }

        /*
            needle of our speedometer , its rotation properly is used here
            to mimic the needle movement
        */
        Rectangle{
            id:needle
            width : 4
            height : parent.width / 3.9

            //anchors
            anchors{
                horizontalCenter: parent.horizontalCenter
                bottom: parent.verticalCenter
            }
            //default rotation is set to be -120
            rotation : -149
            /*
                origin is were the rotation point is defined, here i have set it at the
                bottom of the current item
            */
            transformOrigin : Item.Bottom
            color : "Black"

            /*
                To make the movement of the needle smooth enabled these properties
                feel free to change and see the difference
            */
            antialiasing: true
            smooth: true

            // Animation on Gauge is due to this
            Behavior on rotation{

                SpringAnimation{
                    damping: 1
                    epsilon: .5
                    mass: 4
                    spring: 1
                }
            }

            /*
                the canvas needs to know if the rotation property is changes
                so we need to invoke requestPaint() method so that canvas can
                updat
            */

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

        /*
            To make the movement of the needle smooth enabled these properties
            feel free to change and see the difference
        */
        antialiasing: true
        smooth: true

        /* this is all Maths , idk */

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

            /*

            var ctx = getContext("2d")
            ctx.clearRect(0, 0, mCanvas1.width, mCanvas1.height);
            ctx.fillStyle = "blue"
            ctx.fillRect(20,20,val,60)
            ctx.restore()

            */

            var ctx = getContext("2d")
            ctx.clearRect(0, 0, mCanvas1.width, mCanvas1.height);
            ctx.beginPath();
            ctx.lineWidth = 25;
            ctx.strokeStyle = ((mCanvas1.val > 200)? "#ED1C24" : "#CEDEF8")
            ctx.shadowBlur = 4.47
            ctx.shadowOffsetX = 5.45
            /*

            Syntax
            context.arc(x, y, r, sAngle, eAngle, counterclockwise)

            Param                       Description

                x                       The x-coordinate of the center of the circle
                y                       The y-coordinate of the center of the circle
                r                       The radius of the circle
                sAngle                  The starting angle, in radians (0 is at the 3 o'clock position of the arc's circle)
                eAngle                  The ending angle, in radians
                counterclockwise        Optional. Specifies whether the drawing should be counterclockwise or clockwise.
                                        False is default, and indicates clockwise, while true indicates counter-clockwise.

            */
            ctx.arc(mCanvas1.centerWidth, mCanvas1.centerHeight, mCanvas1.radius - (ctx.lineWidth / 2) - 75, mCanvas1.angleOffset, mCanvas1.angleOffset + mCanvas1.angle);
            ctx.stroke();

        }

        focus: true

        /*
            Rotation of the needle is updated here
        */
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
