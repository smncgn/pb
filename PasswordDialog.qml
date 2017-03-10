import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Dialog {
    id: root

    signal passwordCorrect()

    x: (parent.width - width) / 2
    y: (parent.height - height) /2

    parent: ApplicationWindow.overlay

    focus: true
    modal: true

    contentItem:

        GridLayout {
        id: grid
        rows: 5
        columns: 3

        TextField {
            id: password_field
            focus: true
            Layout.columnSpan: 3
            Layout.fillWidth: true

            placeholderText: "Passcode"
            echoMode: TextField.PasswordEchoOnEdit

        }

        // Reihe 1-3
        Button {
            text: "1"
            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: password_field.insert(password_field.length, text)
        }

        Button {
            text: "2"
            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: password_field.insert(password_field.length, text)
        }

        Button {
            text: "3"
            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: password_field.insert(password_field.length, text)
        }

        // Reihe 4-6
        Button {
            text: "4"
            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: password_field.insert(password_field.length, text)
        }

        Button {
            text: "5"
            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: password_field.insert(password_field.length, text)
        }

        Button {
            text: "6"
            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: password_field.insert(password_field.length, text)
        }

        // Reihe 7-9
        Button {
            text: "7"
            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: password_field.insert(password_field.length, text)
        }

        Button {
            text: "8"
            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: password_field.insert(password_field.length, text)
        }

        Button {
            text: "9"
            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: password_field.insert(password_field.length, text)
        }

        // Reihe C0E
        Button {
            text: "C"
            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: password_field.text = ""
        }

        Button {
            text: "0"
            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: password_field.insert(password_field.length, text)
        }


        Button {
            text: "E"
            Layout.fillWidth: true
            Layout.fillHeight: true

            onClicked: checkPasscode(password_field.text)
        }

    }

    function checkPasscode(text){
        if("0071" === text){
            console.log("correct")
            passwordCorrect()            
        } else {
            console.log("incorrect")
        }

    }
}


