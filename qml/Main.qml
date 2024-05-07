import QtQuick 2.15
import QtQuick.Controls 2.15
import "./component"

ApplicationWindow {
    id: root
    visible: true
    width: 1160
    height: 480
    title: "mavsdk_client"

    property string ip: "172.17.0.2"

    property real leaderDroneIndex: -1

    onLeaderDroneIndexChanged: {
        console.log('onLeaderDroneIndexChanged ' + leaderDroneIndex)
    }
    function setLeaderDroneIndex(index) {
        leaderDroneIndex = index
        console.log('setLeaderDroneIndex ' + index)
        switch (leaderDroneIndex) {
        case -1:
            swarmWidget0.isFollowerEnabled = false
            swarmWidget1.isFollowerEnabled = false
            swarmWidget2.isFollowerEnabled = false
            swarmWidget3.isFollowerEnabled = false
            break
        case 0:
            swarmWidget1.isLeaderOn = false
            swarmWidget2.isLeaderOn = false
            swarmWidget3.isLeaderOn = false

            swarmWidget0.isFollowerEnabled = false
            swarmWidget1.isFollowerEnabled = true
            swarmWidget2.isFollowerEnabled = true
            swarmWidget3.isFollowerEnabled = true
            break
        case 1:
            swarmWidget0.isLeaderOn = false
            swarmWidget2.isLeaderOn = false
            swarmWidget3.isLeaderOn = false

            swarmWidget0.isFollowerEnabled = true
            swarmWidget1.isFollowerEnabled = false
            swarmWidget2.isFollowerEnabled = true
            swarmWidget3.isFollowerEnabled = true
            break
        case 2:
            swarmWidget0.isLeaderOn = false
            swarmWidget1.isLeaderOn = false
            swarmWidget3.isLeaderOn = false

            swarmWidget0.isFollowerEnabled = true
            swarmWidget1.isFollowerEnabled = true
            swarmWidget2.isFollowerEnabled = false
            swarmWidget3.isFollowerEnabled = true
            break
        case 3:
            swarmWidget0.isLeaderOn = false
            swarmWidget1.isLeaderOn = false
            swarmWidget2.isLeaderOn = false

            swarmWidget0.isFollowerEnabled = true
            swarmWidget1.isFollowerEnabled = true
            swarmWidget2.isFollowerEnabled = true
            swarmWidget3.isFollowerEnabled = false
            break
        }

        if (leaderDroneIndex >= 0 && leaderDroneIndex < 4) {
            mainController.setLeaderDrone(leaderDroneIndex)
        }
    }

    Row {
        id: dronesRow
        spacing: 10

        Column {
            spacing: 10

            ConnectionWidget {
                id: connectionWidget0
                ipInputText: root.ip
                portInputText: "14581"

                onConnectButtonClicked: {
                    mainController.connect(0, ipInputText, portInputText)
                }
            }
            DroneStatusWidget {
                drone: drone0
            }
            SwarmWidget {
                id: swarmWidget0
                onIsLeaderOnChanged: {
                    console.log('onIsLeaderOnChanged 0 ' + isLeaderOn)
                    if (isLeaderOn) {
                        setLeaderDroneIndex(0)
                    } else {
                        if (leaderDroneIndex === 0) {
                            setLeaderDroneIndex(-1)
                        }
                    }
                }
                onIsFollowerOnChanged: {
                    if (isFollowerOn) {
                        mainController.addFollowerDrone(0, distance, angle)
                    } else {
                        mainController.removeFollowerDrone(0)
                    }
                }
            }
        }
        Column {
            spacing: 10

            ConnectionWidget {
                id: connectionWidget1
                ipInputText: root.ip
                portInputText: "14582"

                onConnectButtonClicked: {
                    mainController.connect(1, ipInputText, portInputText)
                }
            }
            DroneStatusWidget {
                drone: drone1
            }
            SwarmWidget {
                id: swarmWidget1
                onIsLeaderOnChanged: {
                    console.log('onIsLeaderOnChanged 1 ' + isLeaderOn)
                    if (isLeaderOn) {
                        setLeaderDroneIndex(1)
                    } else {
                        if (leaderDroneIndex === 1) {
                            setLeaderDroneIndex(-1)
                        }
                    }
                }
                onIsFollowerOnChanged: {
                    if (isFollowerOn) {
                        mainController.addFollowerDrone(1, distance, angle)
                    } else {
                        mainController.removeFollowerDrone(1)
                    }
                }
            }
        }
        Column {
            spacing: 10

            ConnectionWidget {
                id: connectionWidget2
                ipInputText: root.ip
                portInputText: "14583"

                onConnectButtonClicked: {
                    mainController.connect(2, ipInputText, portInputText)
                }
            }
            DroneStatusWidget {
                drone: drone2
            }
            SwarmWidget {
                id: swarmWidget2
                onIsLeaderOnChanged: {
                    console.log('onIsLeaderOnChanged 2 ' + isLeaderOn)
                    if (isLeaderOn) {
                        setLeaderDroneIndex(2)
                    } else {
                        if (leaderDroneIndex === 2) {
                            setLeaderDroneIndex(-1)
                        }
                    }
                }
                onIsFollowerOnChanged: {
                    if (isFollowerOn) {
                        mainController.addFollowerDrone(2, distance, angle)
                    } else {
                        mainController.removeFollowerDrone(2)
                    }
                }
            }
        }
        Column {
            spacing: 10

            ConnectionWidget {
                id: connectionWidget3
                ipInputText: root.ip
                portInputText: "14584"

                onConnectButtonClicked: {
                    mainController.connect(3, ipInputText, portInputText)
                }
            }
            DroneStatusWidget {
                drone: drone3
            }
            SwarmWidget {
                id: swarmWidget3
                onIsLeaderOnChanged: {
                    if (isLeaderOn) {
                        console.log('onIsLeaderOnChanged 3 ' + isLeaderOn)
                        setLeaderDroneIndex(3)
                    } else {
                        if (leaderDroneIndex === 3) {
                            setLeaderDroneIndex(-1)
                        }
                    }
                }
                onIsFollowerOnChanged: {
                    if (isFollowerOn) {
                        mainController.addFollowerDrone(3, distance, angle)
                    } else {
                        mainController.removeFollowerDrone(3)
                    }
                }
            }
        }
    }

    Column {
        anchors.top: dronesRow.bottom
        spacing: 2

        TextButton {
            id: offboardBtn
            width: 80
            height: 30
            text:  'offboard'
            textSize: 14
            normalColor: 'lavender'
            radius: 4
            onBtnClicked: {
                mainController.readyToFollow()
            }
        }
        TextButton {
            id: followBtn
            width: 80
            height: 30
            text:  'follow'
            textSize: 14
            normalColor: 'lavender'
            radius: 4
            onBtnClicked: {
                mainController.followLeader()
            }
        }
        TextButton {
            id: stopBtn
            width: 80
            height: 30
            text:  'stop'
            textSize: 14
            normalColor: 'lavender'
            radius: 4
            onBtnClicked: {
                mainController.stopFollow()
            }
        }
    }
}