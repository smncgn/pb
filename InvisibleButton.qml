import QtQuick 2.0

Rectangle {
    width: 144
    height: 70
    color: "transparent"

    signal buttonClicked

    MouseArea {
        anchors.fill: parent

        onClicked: buttonClicked()
    }
}
