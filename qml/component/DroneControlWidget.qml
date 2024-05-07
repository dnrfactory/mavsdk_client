import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: root
    width: 280
    height: 480
    color: 'lightgray'

    readonly property real itemSpacing: 2
    readonly property real btnWidth: (root.width - itemSpacing * 4) / 3
    readonly property real itemHeight: 20

    signal btnArmClicked()
    signal btnStartOffboardClicked()
    signal btnStopOffboardClicked()
    signal btnVelocityBodySetClicked(real val1, real val2, real val3, real val4)
    signal btnVelocityNedSetClicked(real val1, real val2, real val3, real val4)
    signal btnAttitudeSetClicked(real val1, real val2, real val3, real val4)
    signal btnPositionNedSetClicked(real val1, real val2, real val3, real val4)

    Column {
        id: column
        padding: itemSpacing
        spacing: itemSpacing

        Row {
            height: itemHeight
            spacing: itemSpacing

            TextButton {
                id: armBtn
                width: root.btnWidth
                height: parent.height
                text:  'Arm'
                textSize: 12
                normalColor: 'lavender'
                radius: 4
                onBtnClicked: {
                    console.log('%1 button clicked.'.arg(text))
                    btnArmClicked()
                }
            }
            TextButton {
                id: offboardBtn
                width: root.btnWidth
                height: parent.height
                text:  'Offboard start'
                textSize: 12
                normalColor: 'lavender'
                radius: 4
                onBtnClicked: {
                    console.log('%1 button clicked.'.arg(text))
                    btnStartOffboardClicked()
                }
            }
            TextButton {
                id: offboardStopBtn
                width: root.btnWidth
                height: parent.height
                text:  'Offboard stop'
                textSize: 12
                normalColor: 'lavender'
                radius: 4
                onBtnClicked: {
                    console.log('%1 button clicked.'.arg(text))
                    btnStopOffboardClicked()
                }
            }
        }
        
        KeyInputSetWidget {
            width: root.width
            itemSpacing: root.itemSpacing
            
            titleText: "Velocity Body Control"

            key1Text: "Forward"
            key2Text: "Right"
            key3Text: "Down"
            key4Text: "Yaw Anguler Rate"

            input1Text: "0.0"
            input2Text: "0.0"
            input3Text: "0.0"
            input4Text: "0.0"

            Component.onCompleted: btnSetClicked.connect(root.btnVelocityBodySetClicked)
        }

        KeyInputSetWidget {
            width: root.width
            itemSpacing: root.itemSpacing

            titleText: "Velocity NED Control"

            key1Text: "North"
            key2Text: "East"
            key3Text: "Down"
            key4Text: "Yaw In Degrees"

            input1Text: "0.0"
            input2Text: "0.0"
            input3Text: "0.0"
            input4Text: "0.0"

            Component.onCompleted: btnSetClicked.connect(root.btnVelocityNedSetClicked)
        }
        KeyInputSetWidget {
            width: root.width
            itemSpacing: root.itemSpacing

            titleText: "Attitude Control"

            key1Text: "Roll"
            key2Text: "Pitch"
            key3Text: "Yaw"
            key4Text: "Thrust"

            input1Text: "0.0"
            input2Text: "0.0"
            input3Text: "0.0"
            input4Text: "0.0"

            Component.onCompleted: btnSetClicked.connect(root.btnAttitudeSetClicked)
        }
        KeyInputSetWidget {
            width: root.width
            itemSpacing: root.itemSpacing

            titleText: "Position NED Control"

            key1Text: "North"
            key2Text: "East"
            key3Text: "Down"
            key4Text: "Yaw In Degrees"

            input1Text: "0.0"
            input2Text: "0.0"
            input3Text: "0.0"
            input4Text: "0.0"

            Component.onCompleted: btnSetClicked.connect(root.btnPositionNedSetClicked)
        }
    }
}