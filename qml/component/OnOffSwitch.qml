import QtQuick 2.15

Rectangle {
    id: root

    width: 60
    height: 30
    radius: 5
    enabled: true
    color: "lightgrey"

    property bool isOn: false

    onIsOnChanged: {
        console.log("onIsOnChanged " + isOn)
    }

    Rectangle {
        id: handlebg

        anchors.fill: parent
        anchors.margins: 3
        radius: 5
    }

    Rectangle {
        id: handle

        width: parent.width * 0.4
        height: parent.height * 0.8
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 3
        radius: 5
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.isOn = !root.isOn
        }
    }

    states: [
        State {
            name: "disabled"
            when: root.enabled === false

            PropertyChanges {
                target: handlebg
                color: "grey"
            }
            PropertyChanges {
                target: handle
                color: "lightgrey"
            }
            AnchorChanges {
                target: handle
                anchors.left: root.left
            }
        },
        State {
            name: "off"
            when: root.enabled === true && root.isOn === false

            PropertyChanges {
                target: handlebg
                color: "grey"
            }
            PropertyChanges {
                target: handle
                color: "white"
            }
            AnchorChanges {
                target: handle
                anchors.left: root.left
            }
        },
        State {
            name: "on"
            when: root.enabled === true && root.isOn === true

            PropertyChanges {
                target: handlebg
                color: "lightgreen"
            }
            PropertyChanges {
                target: handle
                color: "white"
            }
            AnchorChanges {
                target: handle
                anchors.right: root.right
            }
        }
    ]
}