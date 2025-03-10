import QtQuick
import QtQuick.Controls

Rectangle{
    id:fullscreen
    anchors{
        left:parent.left
        right:parent.right
        bottom:parent.bottom
        top:parent.top
    }
    MouseArea{
        anchors.fill:parent
        onClicked: {
            listshower.model = radio.myList
        }
    }
    color:"transparent"
    Image {
        id: bckImage
        anchors{
            top:parent.top
            bottom:parent.bottom
            left:parent.left
        }
        source: con.mainBGred
    }
    Rectangle{
        id:middle
        width:parent.width  * .90
        height:parent.height * .70
        color:"transparent"
        anchors{
            horizontalCenter:parent.horizontalCenter
            verticalCenter:parent.verticalCenter
            verticalCenterOffset:-20
        }
        Rectangle{
            id:showFm
            width:parent.width/2
            height:parent.height * .40
            color:"transparent"
            anchors{
                horizontalCenter:parent.horizontalCenter
            }
            Rectangle{
                id:fmTextBox
                height:200
                width:300
                color:"transparent"
                anchors{
                    centerIn:parent
                    topMargin:50
                }
                Label{
                    id:fmTextlabel
                    text:radio.fm
                    clip:true
                    font.family:"Arial"
                    font.pixelSize:30
                    anchors.centerIn:parent
                }
                Label{
                    text: "Khz"
                    font.pixelSize:20
                    anchors{
                        topMargin:5
                        top:fmTextlabel.bottom
                        horizontalCenter:parent.horizontalCenter
                    }
                }
                Label{
                    text: "FM"
                    font.pixelSize:20
                    anchors{
                        topMargin:10
                        top:parent.top
                        horizontalCenter:parent.horizontalCenter
                    }
                }
            }
            Rectangle{
                id:forward
                height:50
                anchors{
                    left:parent.left
                    right:fmTextBox.left
                    verticalCenter:parent.verticalCenter
                }
                color:"transparent"
                Image {
                    id: playback
                    height:30
                    width:80
                    source: "Assets/playBack.png"
                    anchors{
                        centerIn:parent
                    }
                    fillMode:Image.PreserveAspectFit
                    MouseArea{
                        anchors.fill:parent
                        onClicked:{
                            radio.changeListBackward()
                        }
                    }
                }
            }
            Rectangle{
                id:back
                height:50
                anchors{
                    left:fmTextBox.right
                    right:parent.right
                    verticalCenter:parent.verticalCenter
                }
                color:"transparent"
                Image {
                    id: playnext
                    height:30
                    width:80
                    source: "Assets/playNext.png"
                    anchors{
                        centerIn:parent
                    }
                    fillMode:Image.PreserveAspectFit
                    MouseArea{
                        anchors.fill:parent
                        onClicked:{
                            radio.changeListForward()
                        }
                    }
                }
            }
        }


        Rectangle{
            id:list1
            anchors{
                top:showFm.bottom
                bottom:middle.bottom
                horizontalCenter:parent.horizontalCenter
            }
            width:parent.width/2
            color:"transparent"
            Column{
                id:columLayout
                spacing:2
                width:parent.width
                height:parent.height
                Rectangle{
                    color:"transparent"
                    width:parent.width
                    height:parent.height * 0.4

                    Image {
                        visible:true
                        id: savebtn
                        source:con.fm_Add_red
                        anchors{
                            top:parent.top
                            bottom:parent.bottom
                            left:parent.left
                            leftMargin:120
                        }
                         fillMode:Image.PreserveAspectFit
                        MouseArea{
                            anchors.fill:parent
                            onClicked:{
                                radio.savePreset()
                            }
                        }
                    }
                    Image {
                        visible:true
                        id: bandbtn
                        source: con.fm_Stop_red
                        anchors{
                            top:parent.top
                            bottom:parent.bottom
                            left:savebtn.right
                            leftMargin:30
                        }
                        fillMode:Image.PreserveAspectFit
                        MouseArea{
                            anchors.fill:parent
                            onClicked:{
                                radio.stopFm()
                            }
                        }
                    }
                    Image {
                        visible:true
                        id: playBtn
                        source: con.fm_play_red  //radio.power ?Assets/powerOn.png: Assets/powerOff.png
                        anchors{
                            top:parent.top
                            bottom:parent.bottom
                            left:bandbtn.right
                            leftMargin:30
                        }
                        fillMode:Image.PreserveAspectFit
                        MouseArea{
                            anchors.fill:parent
                            onClicked:{
                                radio.playFm()
                            }
                        }

                    }
                }
                Rectangle{
                    color:"transparent"
                    width:parent.width
                    height:parent.height * 0.6
                    GridView{
                        id:listItems
                        width:parent.width
                        cellWidth: parent.width/3
                        cellHeight: parent.height/2
                        height:parent.height
                        anchors{
                            top:savebtn.bottom
                            left:parent.left
                            right:parent.right
                            bottom:parent.bottom
                        }
                        model:radio.preset
                        delegate:Rectangle{
                            color:"transparent"
                            width:listItems.cellWidth
                            height:listItems.cellHeight
                            Image {
                                id: backgroundim
                                source: con.listBGred
                                anchors{
                                    top:parent.top
                                    bottom:parent.bottom
                                    left:parent.left
                                    right:parent.right
                                    margins:3
                                }
                                Text{
                                    clip:true
                                    text:modelData
                                    font.pixelSize:20
                                    anchors.centerIn:parent
                                    color:"white"
                                }
                                MouseArea{
                                    anchors{
                                        left :parent.left
                                        top:parent.top
                                        bottom:parent.bottom

                                    }
                                    width:parent.width/2
                                    onClicked:{

                                            radio.loadPreset(index)

                                    }

                                }
                                MouseArea{
                                    anchors{
                                        right :parent.right
                                        top:parent.top
                                        bottom:parent.bottom

                                    }
                                    width:parent.width/2
                                    onDoubleClicked:{

                                        radio.removePreset(index)
                                    }

                                }

                            }
                        }
                    }
                }

            }
        }
    }

    ListView{
        anchors{
            left:fullscreen.left
            top:parent.top
            bottom:parent.bottom
            leftMargin: 10
        }
        width:300
        height:50
        id:listshower
        model:  radio.myList
        delegate:Rectangle{
            color:"transparent"
            width:listshower.width
            height:50
            Image {
                id: backgroungimg
                source: con.listBGred
                anchors{
                    top:parent.top
                    bottom:parent.bottom
                    left:parent.left
                    right:parent.right
                    margins:3
                }
                Text{
                    clip:true
                    text:modelData
                    font.pixelSize:15
                    anchors.centerIn:parent
                    color:"white"
                    MouseArea{
                        anchors{
                            fill:parent
                        }

                        onClicked:{
                            radio.loadPresetFromList(index)

                        }
                    }
                }
            }
        }
    }
    Button{
        id:btn1
        anchors{
            right:parent.right
        }
        text :"click for green"
        onClicked:{
            //bckImage.source = con.mainBGgreen
          //  background.source = con.listBGgreen
            con.listBGred = "Assets/listBackgroud_green.png"
            savebtn.source=con.fm_Add_green
            bckImage.source = con.mainBGgreen
            bandbtn.source=con.fm_Stop_green
            playBtn.source=con.fm_play_green
            backgroungimg.source = con.listBGgreen
            //background.source=con.listBGgreen

        }
    }
    Button{
        id:btn2
        anchors{
            right:parent.right
            top:btn1.bottom
        }
        text :"click for light"
        onClicked:{
            savebtn.source=con.fm_Add_light
            bckImage.source = con.mainBGlight
            bandbtn.source=con.fm_Stop_light
            //background.source=con.listBGlight
            playBtn.source=con.fm_play_light
            con.listBGred = "Assets/listBackground_light.png"
        }
    }
    Button{
        id:btn3
        anchors{
            right:parent.right
            top:btn2.bottom
        }
        text :"click for brown"
        onClicked:{
            savebtn.source=con.fm_Add_brown
            bckImage.source = con.mainBGbrown
            bandbtn.source=con.fm_Stop_brown
            playBtn.source=con.fm_play_brown
            con.listBGred = "Assets/listBackground_brown.png"
        }
    }
    Button{
        id:btn4
        anchors{
            right:parent.right
            top:btn3.bottom
        }
        text :"click for blue"
        onClicked:{
            savebtn.source=con.fm_Add_blue
            bckImage.source = con.mainBGblue
            bandbtn.source=con.fm_Stop_blue
            playBtn.source=con.fm_play_blue
            con.listBGred = "Assets/listBackground_blue.png"
        }
    }
    Button{
        id:btn5
        anchors{
            right:parent.right
            top:btn4.bottom
        }
        text :"click for red"
        onClicked:{
            savebtn.source=con.fm_Add_red
            bckImage.source = con.mainBGred
            bandbtn.source=con.fm_Stop_red
            playBtn.source=con.fm_play_red
            con.listBGred = "Assets/listBackground_red.png"
        }
    }

}
