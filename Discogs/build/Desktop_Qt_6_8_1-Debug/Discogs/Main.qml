import QtQuick
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    Column {
        spacing: 10
        padding: 20

        TextField {
            id: searchField
            placeholderText: "Enter language"
        }

        Button {
            text: "Fetch Releases"
            onClicked: {
                DiscogsApi.fetchReleases(searchField.text);
            }
        }

        ListView {
            id: releasesList
            width: parent.width
            height: 300
            model: ListModel {}

            delegate: Item {
                width: releasesList.width
                height: 50
                Text {
                    text: model.display
                }
            }
        }

        Connections {
            target: DiscogsApi
            onReleasesFetched: {
                releasesList.model.clear();
                for (var i = 0; i < releases.length; i++) {
                    releasesList.model.append({ display: releases[i].title });
                }
            }
            onErrorOccurred: {
                console.log("Error: " + error);
            }
        }
    }
}
