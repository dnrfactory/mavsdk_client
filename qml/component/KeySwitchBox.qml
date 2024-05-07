import QtQuick 2.5

Row {
    id: root

    property alias wKey: rectKey.width
    property alias textKey: rectKeyText.text
    property alias switchEnabled: onOffSwitch.enabled
    property alias switchOn: onOffSwitch.isOn

    onSwitchOnChanged: {
        console.log("onSwitchOnChanged " + switchOn)
    }

    Rectangle {
        id: rectKey
        height: parent.height
        color: "darkgray"
        radius: 4
        Text {
            id: rectKeyText
            anchors.centerIn: parent
        }
    }

    OnOffSwitch {
        id: onOffSwitch
    }
}