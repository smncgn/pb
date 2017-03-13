import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Page {
    id: root
    focus: true

    signal takePhoto(int nr)
    signal showAppSettings()
    signal showSlideShow()

    Column {
        id: selection
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 66

        spacing: 12

        // Button Ein Foto
        ButtonWithIcon {
            text: "EIN FOTO"
            icon: "qrc:/icons/ic_portrait_black_36dp_1x.png"

            width: parent.width

            onClicked: takePhoto(1)
        }

        // Button Vier Fotos
        ButtonWithIcon {
            text: "VIER FOTOS"
            icon: "qrc:/icons/ic_photo_library_black_36dp_1x.png"

            onClicked: takePhoto(4)
        }

        // Button Diashow
        ButtonWithIcon {
            text: "DIASHOW"
            icon: "qrc:/icons/ic_slideshow_black_36dp_1x.png"

            width: parent.width

            onClicked: showSlideShow()

        }

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
