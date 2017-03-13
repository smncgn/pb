import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtGraphicalEffects 1.0

Button {
    id: root

    property alias icon: icon.source

    FontLoader {
        id: robotoMedium
        source: "qrc:/fonts/Roboto-Medium.ttf"
    }

    focusPolicy: Qt.NoFocus
    leftPadding: 12
    rightPadding: 12
    height: 54

    contentItem: Row {
        leftPadding: 12
        rightPadding: 12

        spacing: 12

        Image {
            id: icon
            source: "qrc:/icons/ic_portrait_black_36dp_1x.png"

            sourceSize.height: 36
            sourceSize.width: 36

            anchors.verticalCenter: parent.verticalCenter

            ColorOverlay {
                anchors.fill: icon
                source: icon
                color: Material.accent
            }
        }

        Label {
            id: label
            anchors.verticalCenter: parent.verticalCenter
            text: root.text
            font.family: robotoMedium.name
            font.pixelSize: 21
        }


    }


}
