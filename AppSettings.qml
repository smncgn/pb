import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1

Page {
    id: root
    focus: true

    // Button zum Unterbrechen
    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10

        text: "Quit"

        onClicked: Qt.quit()

    }
}
