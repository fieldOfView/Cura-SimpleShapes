// Import the standard GUI elements from QTQuick
import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.2

// Import the Uranium GUI elements, which are themed for Cura
import UM 1.1 as UM
import Cura 1.0 as Cura

// Dialog
Window
{
    id: base

    title: "Calibration Shapes"

    color: "#fafafa" //Background color of cura: #fafafa

    // NonModal like that the dialog to block input in the main window
    modality: Qt.NonModal

    // WindowStaysOnTopHint to stay on top
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.WindowCloseButtonHint

    // Setting the dimensions of the dialog window
    width: 300
    height: 50
    minimumWidth: 350
    minimumHeight: 50

    // Position of the window
    x: Screen.width*0.5 - width - 50
    y: 400 

    // Define a Window a border (Red for) and a background color
    Rectangle {
        id: bg_rect
        width: 300
        height: 50
        color: "#fff"
        border.color: "#D22"
        border.width: 3
        radius: 2
    }

    // Connecting our variable to the computed property of the manager
    property string userInfoText: manager.userInfoText

    // Button for closing the dialogbox
    Button
    {
        id: close_button
        text: "<font color='#ffffff'>" + "x" + "</font>"
        width: 25
        height: 25

        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

        tooltip: "Close this dialog box"

        style: ButtonStyle{
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 25
                radius: 3
                color: "#D22"
            }
        }

        onClicked:
        {
            base.close();
        }
    }

    //Text "Size: "
    Text
    {
        id: text_size
        text: "Size:"
        font.family: "Arial"
        font.pointSize: 12
        color: "#131151"

        anchors.top: close_button.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    //User input of height
    TextField
    {
        id: size_input
        width: 80
        text: ""
        placeholderText: "ie. 20.0"

        anchors.bottom: text_size.bottom
        anchors.bottomMargin: 0
        anchors.left: text_size.right
        anchors.leftMargin: 10

        font.pointSize: 12

        // The window musn't close when enter is pressed
        // Keys.onReturnPressed:
        // {
        //    event.accepted = true
        // }

        // Return the new entered value
        Keys.onReleased:
        {
            manager.sizeEntered(size_input.text)
        }
    }

    //Text: "mm"
    Text
    {
        id: text_unit
        text: "mm"
        font.family: "Arial"
        font.pointSize: 12
        color: "#131151"

        anchors.bottom: text_size.bottom
        anchors.bottomMargin: 0
        anchors.left: size_input.right
        anchors.leftMargin: 5
    }

    //This Button only exists to hold the help Tooltip
    Button
    {
        id: help_button
        text: "<font color='#888'>" + "?" + "</font>"
        //text: "?"
        width: 21
        height: 21

        anchors.bottom: close_button.bottom
        anchors.bottomMargin: 2
        anchors.right: close_button.left
        anchors.rightMargin: 5

        tooltip:
        "This plugin offer you the possibility to define a standard sized element.
        Define in the Size field the default size for the element"

        onClicked:
        {
            //do button action
            manager.buttonHelpPressed()
        }

        style: ButtonStyle{
            background: Rectangle {
                implicitWidth: 15
                implicitHeight: 15
                radius: 10
                color: "#fafafa"
                border.width: 1
                border.color: "#888"
            }
        }

    }


    //Textfield for User Messages
    Text
    {
        id: user_text

        width: 280
        anchors.top: button_continue.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10

        //text: "Info"
        text: userInfoText

        font.family: "Arial"
        font.pointSize: 11
        //The color gets overwritten by the html tags added to the text
        color: "black"

        wrapMode: Text.Wrap
    }

}
