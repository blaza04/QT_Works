 import QtQuick
 import QtQuick.Controls

 Item{
     id:myAnimate
     anchors.fill:parent
     anchors.margins:10
     property var count : 0
     property var flag : 0
     Column{
         id:mycolumn
         anchors.centerIn:parent
         spacing:10
         Repeater{
             model:myAnimate.count
             Row{
                 spacing:10
                 Repeater{
                     model:myAnimate.count
                     Rectangle{
                     width:50
                     height:50
                     color:"blue"
                    }
                }
            }
        }
    }
    Button{
        id:myButton
        text:"click me"
        anchors.horizontalCenter:parent.horizontalCenter
        anchors.margins:10
        onClicked:{
             if(myAnimate.count<5 && myAnimate.flag==0){
                 myAnimate.count++
             }
             else {
                 myAnimate.flag = 1
             }
             if(myAnimate.flag==1){
                 myAnimate.count--
             }
             if(myAnimate.count==0){
                 myAnimate.flag=0
             }

         }
      }
 }

