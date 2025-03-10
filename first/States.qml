import QtQuick
import QtQuick.Controls
Item {
   id:myStates
   anchors.fill:parent
   Rectangle{
       y:10
       x:10
       id:rect1
       height:100
       width:100
       radius:200
       color:"black"
   }
   Rectangle{
       x:10
       y:120
       id:rect2
       height:100
       width:100
       radius:200
       color:"black"
   }
   Rectangle{
       x:10
       y:240
       id:rect3
       height:100
       width:100
       radius:200
       color:"black"
   }
       state:"go"
       states: [
           State {
               name: "stop"
               PropertyChanges {
                   target: rect1
                   color:"red"
               }
               PropertyChanges {
                   target: rect2
                   color:"black"
               }
               PropertyChanges {
                   target: rect3
                   color:"black"
               }
           },
           State {
               name: "go"
               PropertyChanges {
                   target: rect1
                   color:"black"
               }
               PropertyChanges {
                   target: rect2
                   color:"green"
               }
               PropertyChanges {
                   target: rect3
                   color:"black"
               }
           }
       ]
   Button{
       id:myButton
       text:"click"
       anchors.horizontalCenter:parent.horizontalCenter
       onClicked:myStates.state="stop"
   }
   transitions: [
       Transition {
           from: "go"
           to: "stop"

           ColorAnimation {
               target:rect1
               properties :"color"
               duration: 2000
           }
           ColorAnimation {
               target:rect2
               properties :"color"
               duration: 2000
           }
           ColorAnimation {
               target:rect3
               properties :"color"
               duration: 2000
           }

       }
   ]
}

