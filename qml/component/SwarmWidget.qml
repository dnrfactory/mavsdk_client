import QtQuick 2.5

Item {
    id: root
    width: 280
    height: 130

    property alias distance: distanceInputText.inputText
    property alias angle: angleInputText.inputText

    property alias isLeaderOn: leaderSwitch.switchOn
    property alias isFollowerOn: followerSwitch.switchOn
    property alias isFollowerEnabled: followerSwitch.switchEnabled

    onIsLeaderOnChanged: {
        console.log("onIsLeaderOnChanged " + isLeaderOn)
    }
    onIsFollowerOnChanged: {
        console.log("onIsFollwerOnChanged " + isFollowerOn)
    }
    onDistanceChanged: {
        console.log("onDistanceChanged " + distance)
    }
    onAngleChanged: {
        console.log("onAngleChanged " + angle)
    }

    Column {
        spacing: 2

        KeySwitchBox {
            id: leaderSwitch
            wKey: 80
            textKey: "Leader"
            height: 30
        }
        KeySwitchBox {
            id: followerSwitch
            wKey: 80
            textKey: "Follower"
            height: 30
            switchEnabled: false
        }
        KeyInputTextBox {
            id: distanceInputText
            wKey: 80
            textKey: "distance"
            inputText: "10.0"
        }
        KeyInputTextBox {
            id: angleInputText
            wKey: 80
            textKey: "angle"
            inputText: "0.0"
        }
    }
}