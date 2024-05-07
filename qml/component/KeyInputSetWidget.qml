import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Column {
    id: root
    padding: itemSpacing
    spacing: itemSpacing
    
    property real itemSpacing: 2
    property real btnWidth: (root.width - itemSpacing * 4) / 3
    property real itemHeight: 20

    property alias titleText: titleTextItem.text
    
    property alias key1Text: keyValue1.textKey
    property alias key2Text: keyValue2.textKey
    property alias key3Text: keyValue3.textKey
    property alias key4Text: keyValue4.textKey
    
    property alias input1Text: keyValue1.inputText
    property alias input2Text: keyValue2.inputText
    property alias input3Text: keyValue3.inputText
    property alias input4Text: keyValue4.inputText

    signal btnSetClicked(real val1, real val2, real val3, real val4)
    
    Row {
        height: root.itemHeight
        spacing: root.itemSpacing

        Rectangle {
            width: root.btnWidth * 2 + root.itemSpacing
            height: parent.height
            color: "darkgray"
            radius: 4
            Text {
                id: titleTextItem
                anchors.centerIn: parent
                text: "Velocity Body Control"
            }
        }
        TextButton {
            width: root.btnWidth
            height: parent.height
            text:  'Set'
            textSize: 12
            normalColor: 'lavender'
            radius: 4
            onBtnClicked: {
                console.log('%1 button clicked.'.arg(text))
                btnSetClicked(parseFloat(input1Text),
                              parseFloat(input2Text),
                              parseFloat(input3Text),
                              parseFloat(input4Text))
            }
        }
    }
    KeyInputTextBox {
        id: keyValue1
        spacing: root.itemSpacing
        height: root.itemHeight
        wKey: root.btnWidth * 1.5
        wInput: root.btnWidth * 1.5
    }
    KeyInputTextBox {
        id: keyValue2
        spacing: root.itemSpacing
        height: root.itemHeight
        wKey: root.btnWidth * 1.5
        wInput: root.btnWidth * 1.5
    }
    KeyInputTextBox {
        id: keyValue3
        spacing: root.itemSpacing
        height: root.itemHeight
        wKey: root.btnWidth * 1.5
        wInput: root.btnWidth * 1.5
    }
    KeyInputTextBox {
        id: keyValue4
        spacing: root.itemSpacing
        height: root.itemHeight
        wKey: root.btnWidth * 1.5
        wInput: root.btnWidth * 1.5
    }
}