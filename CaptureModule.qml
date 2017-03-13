import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtGraphicalEffects 1.0
import QtMultimedia 5.4

FocusScope {
    property Camera camera
    property int number_of_photos

    FontLoader {
        id: robotoMedium
        source: "qrc:/fonts/Roboto-Regular.ttf"
    }


    id: captureModule

    Pane {
        id: countDownPaneBg

        width: 160
        height: parent.height
        anchors.top: parent.top
        anchors.right: parent.right

        Text {
            id: countDownText
            text: "10"

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font {
                family: robotoMedium.name
                bold: true
                pixelSize: 56
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                margins: 8
            }
        }

        Image {
            id: imageCamera
            visible: false

            source: "qrc:/icons/ic_photo_camera_black_48dp_2x.png"
            sourceSize.height: 96
            sourceSize.width: 96

            width: 64
            height: 64

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            ColorOverlay{
                anchors.fill: imageCamera
                source: imageCamera
                color: Material.accent
            }
        }

        ProgressCircle {
            id: progressCricle
            size: 144
            colorCircle: Material.color(Material.Teal)
            colorBackground: Material.color(Material.Grey)
            showBackground: true
            arcBegin: 0
            arcEnd: 360
            lineWidth: 12


            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
        }
    }

    Timer{
        id: timerCircle
        interval: 1000
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            progressCricle.arcEnd -= delta
        }
    }

    Timer{
        id: timerText
        interval: 1000
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            updateText()
        }
    }




    function start(){
        progressCricle.animationDuration = 10000
        progressCricle.arcEnd = 0
        timerText.start()

        imageCamera.visible = false
    }

    function updateText(){
        if(duration > 0){
            countDownText.text = duration.toString()
            duration -= 1
        } else { // Null erreicht
            countDownText.text = ""
            imageCamera.visible = true
            timerText.stop()

        }
    }

}




