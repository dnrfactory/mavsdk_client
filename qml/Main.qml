import QtQuick 2.15
import QtQuick.Controls 2.15
import "./component"

ApplicationWindow {
    id: root
    visible: true
    width: 1160
    height: 960
    title: "mavsdk_client"

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
                ipInputText: drone0.address_ip
                portInputText: drone0.address_port

                onConnectButtonClicked: {
                    mainController.connect(0, ipInputText, portInputText)
                }
                onIpInputTextChanged: {
                    drone0.address_ip = ipInputText
                }
                onPortInputTextChanged: {
                    drone0.address_port = portInputText
                }
            }
            DroneStatusWidget {
                drone: drone0
            }
            DroneControlWidget {
                onBtnArmClicked: mainController.arm(0)
                onBtnStartOffboardClicked: mainController.startOffboardMode(0)
                onBtnStopOffboardClicked: mainController.stopOffboardMode(0)
                onBtnVelocityBodySetClicked: mainController.setVelocityBody(0, val1, val2, val3, val4)
                onBtnVelocityNedSetClicked: mainController.setVelocityNED(0, val1, val2, val3, val4)
                onBtnAttitudeSetClicked: mainController.setAttitude(0, val1, val2, val3, val4)
                onBtnPositionNedSetClicked: mainController.setPositionNED(0, val1, val2, val3, val4)
            }
            SwarmWidget {
                id: swarmWidget0
                distance: drone0.follow_distance
                angle: drone0.follow_angle
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
                onDistanceChanged: {
                    drone0.follow_distance = distance
                }
                onAngleChanged: {
                    drone0.follow_angle = angle
                }
            }
        }
        Column {
            spacing: 10

            ConnectionWidget {
                id: connectionWidget1
                ipInputText: drone1.address_ip
                portInputText: drone1.address_port

                onConnectButtonClicked: {
                    mainController.connect(1, ipInputText, portInputText)
                }
                onIpInputTextChanged: {
                    drone1.address_ip = ipInputText
                }
                onPortInputTextChanged: {
                    drone1.address_port = portInputText
                }
            }
            DroneStatusWidget {
                drone: drone1
            }
            DroneControlWidget {
                onBtnArmClicked: mainController.arm(1)
                onBtnStartOffboardClicked: mainController.startOffboardMode(1)
                onBtnStopOffboardClicked: mainController.stopOffboardMode(1)
                onBtnVelocityBodySetClicked: mainController.setVelocityBody(1, val1, val2, val3, val4)
                onBtnVelocityNedSetClicked: mainController.setVelocityNED(1, val1, val2, val3, val4)
                onBtnAttitudeSetClicked: mainController.setAttitude(1, val1, val2, val3, val4)
                onBtnPositionNedSetClicked: mainController.setPositionNED(1, val1, val2, val3, val4)
            }
            SwarmWidget {
                id: swarmWidget1
                distance: drone1.follow_distance
                angle: drone1.follow_angle
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
                onDistanceChanged: {
                    drone1.follow_distance = distance
                }
                onAngleChanged: {
                    drone1.follow_angle = angle
                }
            }
        }
        Column {
            spacing: 10

            ConnectionWidget {
                id: connectionWidget2
                ipInputText: drone2.address_ip
                portInputText: drone2.address_port

                onConnectButtonClicked: {
                    mainController.connect(2, ipInputText, portInputText)
                }
                onIpInputTextChanged: {
                    drone2.address_ip = ipInputText
                }
                onPortInputTextChanged: {
                    drone2.address_port = portInputText
                }
            }
            DroneStatusWidget {
                drone: drone2
            }
            DroneControlWidget {
                onBtnArmClicked: mainController.arm(2)
                onBtnStartOffboardClicked: mainController.startOffboardMode(2)
                onBtnStopOffboardClicked: mainController.stopOffboardMode(2)
                onBtnVelocityBodySetClicked: mainController.setVelocityBody(2, val1, val2, val3, val4)
                onBtnVelocityNedSetClicked: mainController.setVelocityNED(2, val1, val2, val3, val4)
                onBtnAttitudeSetClicked: mainController.setAttitude(2, val1, val2, val3, val4)
                onBtnPositionNedSetClicked: mainController.setPositionNED(2, val1, val2, val3, val4)
            }
            SwarmWidget {
                id: swarmWidget2
                distance: drone2.follow_distance
                angle: drone2.follow_angle
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
                onDistanceChanged: {
                    drone2.follow_distance = distance
                }
                onAngleChanged: {
                    drone2.follow_angle = angle
                }
            }
        }
        Column {
            spacing: 10

            ConnectionWidget {
                id: connectionWidget3
                ipInputText: drone3.address_ip
                portInputText: drone3.address_port

                onConnectButtonClicked: {
                    mainController.connect(3, ipInputText, portInputText)
                }
                onIpInputTextChanged: {
                    drone3.address_ip = ipInputText
                }
                onPortInputTextChanged: {
                    drone3.address_port = portInputText
                }
            }
            DroneStatusWidget {
                drone: drone3
            }
            DroneControlWidget {
                onBtnArmClicked: mainController.arm(3)
                onBtnStartOffboardClicked: mainController.startOffboardMode(3)
                onBtnStopOffboardClicked: mainController.stopOffboardMode(3)
                onBtnVelocityBodySetClicked: mainController.setVelocityBody(3, val1, val2, val3, val4)
                onBtnVelocityNedSetClicked: mainController.setVelocityNED(3, val1, val2, val3, val4)
                onBtnAttitudeSetClicked: mainController.setAttitude(3, val1, val2, val3, val4)
                onBtnPositionNedSetClicked: mainController.setPositionNED(3, val1, val2, val3, val4)
            }
            SwarmWidget {
                id: swarmWidget3
                distance: drone3.follow_distance
                angle: drone3.follow_angle
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
                onDistanceChanged: {
                    drone3.follow_distance = distance
                }
                onAngleChanged: {
                    drone3.follow_angle = angle
                }
            }
        }
    }

    Column {
        anchors.topMargin: 8
        anchors.top: dronesRow.bottom
        spacing: 2

        Row {
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
        KeyInputTextBox {
            wKey: 80
            wInput: 120
            textKey: "Frequency"
            inputText: "1.0"
            onInputReturnPressed: {
                mainController.setFollowFrequency(parseFloat(inputText))
            }
        }
    }
}