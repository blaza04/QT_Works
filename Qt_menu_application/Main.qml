import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Application")
    color:"white"
    menuBar : MenuBar{
        Menu{
            title:"open"
            MenuItem{
                text:"new open"
                onTriggered:opendialog.open()
            }
            MenuItem{
                text:"close"
                onTriggered: document.reset()
            }
            MenuItem{
                text:"Quit"
                onTriggered:Qt.quit()
            }
        }
        Menu{
            title:"edit"
            MenuItem{
                text:"undo"
            }
            MenuItem{
                text:"Redo"
            }
            MenuItem{
                text:"View"
            }
        }
        Menu{
            title:"help"
            MenuItem{
                text:"About"
                onTriggered:helpbox.open()
            }
        }
    }
    header:ToolBar{
        ToolButton{
            text:"Insert"
            onClicked:fileselector.open()
        }

    }
    Rectangle{
        color:"grey"
        height:parent.height * .05
        anchors{
            bottom:parent.bottom
            right:parent.right
            left:parent.left
        }
        Row{
            id:col1
            anchors.fill:parent
            spacing:30
            Label{
                text:"consoloe Application"

            }
            Label{
                text:"created with QT"

            }
        }
    }

    Dialog{
        id:opendialog
        title:"open or exit"
        standardButtons: Dialog.Ok | Dialog.Cancel
        onAccepted:fileselector.open()
        onRejected:console.log("cancel clicked")
    }
    MessageDialog{
        id:helpbox
        title:"about"
        buttons:Dialog.ok
        text:"© 2024 The Qt Company Ltd. Documentation contributions included herein are the copyrights of their respective owners. The documentation provided herein is licensed under the terms of the GNU Free Documentation License version 1.3 as published by the Free Software Foundation. Qt and respective logos are trademarks of The Qt Company Ltd. in Finland and/or other countries worldwide. All other trademarks are property of their respective owners.
"
    }
    FileDialog {
        id: fileselector
        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        onAccepted: image.source = selectedFile
    }
    Image{
        id:image
        anchors.fill:parent
        fillMode:Image.PreserveAspectFit
    }
}

