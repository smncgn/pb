import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Page {
    id: root
    focus: true

    signal takePhoto(int nr)
    signal showAppSettings()
    signal showSlideShow()

    // Button Diashow
    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 90

        text: "Diashow"

        onClicked: showSlideShow()

    }

    // Button Ein Foto
    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: -90
        anchors.verticalCenterOffset: -90

        text: "Ein Foto"

        onClicked: takePhoto(1)

    }

    // Button Vier Fotos
    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 90
        anchors.verticalCenterOffset: -90

        text: "Vier Fotos"

        onClicked: takePhoto(4)

    }

    // Versteckter Button Settings
    InvisibleButton {
        id: settings_button

        anchors.top: parent.top
        anchors.right: parent.right

        onButtonClicked: password_dialog.open()

        PasswordDialog {
            id: password_dialog

            onPasswordCorrect: { showAppSettings(); close() }
        }
    }

}
