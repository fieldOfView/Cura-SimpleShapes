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

    // We don't want the dialog to block input in the main window
    modality: Qt.NonModal

    //We want the window to stay on top
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.WindowCloseButtonHint

    // Setting the dimensions of the dialog window and prohibiting resizing
    width: 300
    height: 50
    minimumWidth: 350
    minimumHeight: 50

    //Position the window
    x: Screen.width*0.5 - width - 50
	// 400
    y: 400 

    //This is for giving the Window a boarder and a background color
    Rectangle {
        id: bg_rect
        width: 300
        height: 50
        color: "#fff"
		// "#ededed"
        border.color: "#D22"
        border.width: 3
        radius: 5
    }

    // Connecting our variable to the computed property of the manager
    property string userInfoText: manager.userInfoText

    //This Button is for closing the dialog
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

        tooltip: "close this dialog"

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
        id: test_size
        text: "Size:"
        font.family: "Arial"
        font.pointSize: 14
        color: "#131151"

        anchors.top: close_button.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    //User input of height
    TextField
    {
        id: height_input
        width: 80
        text: ""
        placeholderText: "ie. 20.0"

        anchors.bottom: test_size.bottom
        anchors.bottomMargin: 0
        anchors.left: test_size.right
        anchors.leftMargin: 10

        font.pointSize: 11

        //The window musn't close when enter is pressed
        Keys.onReturnPressed:
        {
            event.accepted = true
        }

        //Return the new entered value
        Keys.onReleased:
        {
            manager.heightEntered(height_input.text)
        }
    }

    //Text: "mm"
    Text
    {
        id: text_unit
        text: "mm"
        font.family: "Arial"
        font.pointSize: 14
        color: "#131151"

        anchors.bottom: test_size.bottom
        anchors.bottomMargin: 0
        anchors.left: height_input.right
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
