import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import QtMultimedia 5.4

FocusScope {
    property Camera camera
    property int number_of_photos

    property int duration: 10

    id: captureModule

    Pane {
        id: countDownPaneBg

        width: 160
        height: parent.height
        anchors.top: parent.top
        anchors.right: parent.right

        //        Material.primary: Material.Teal

        Text {
            id: countDownText
            text: "10"
            height: 64
            width: parent.width - 16

            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            font {
                bold: true
                pixelSize: 56
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
                margins: 8
            }
        }


        ProgressCircle {
            id: progressCricle
            size: 144
            colorCircle: "#607D8B"  // Material BlueGrey
            colorBackground: "#FAFAFA"
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

    }

    function updateText(){
        if(duration > 0){
            countDownText.text = duration.toString()
            duration -= 1
        } else { // Null erreicht
            countDownText.text = ";-)"

            timerText.stop()

        }
    }

}




