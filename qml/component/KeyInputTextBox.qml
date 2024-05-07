import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Row {
    id: root

    height: 30
    spacing: 4

    property alias inputText: inputTextField.text
    property alias placeholderText: inputTextField.placeholderText
    property alias wKey: rectKey.width
    property alias wInput: inputTextField.width
    property alias textKey: rectKeyText.text

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
    TextField {
        id: inputTextField
        width: 120
        height: parent.height
        textColor: 'black'
        style: TextFieldStyle {
            background: Rectangle {
                color: 'lightgray'
                border.color: 'black'
                border.width: 1
            }
        }
    }
}