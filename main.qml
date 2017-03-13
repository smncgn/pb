import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import Qt.labs.settings 1.0
import QtMultimedia 5.4
//import QtQml 2.2

ApplicationWindow {    
    width: 800
    height: 480

    visible: true

    Settings {
        id: settings
        property string style: "Material"
    }

    Rectangle {
        id: mainview
        anchors.fill: parent

        state: "SlideShow"

        states: [
            State {
                name: "SlideShow"
                StateChangeScript {
                    script: {
                        slideShow.startOver()
                    }
                }
            },
            State {
                name: "ModeSelection"
            },
            State {
                name: "CaptureModule"
            },
            State{
                name: "AppSettings"
            },
            State {
                name: "Preview"
            }
        ]



    }


    SlideShow {
        id: slideShow
        anchors.fill: parent

        visible: mainview.state == "SlideShow"
        onShowModeSelection: mainview.state = "ModeSelection"
    }

    ModeSelection {
        id: modeselection
        anchors.fill: parent
        visible:  mainview.state == "ModeSelection"
        onTakePhoto: { console.log(nr + " Foto(s) machen")
            mainview.state = "CaptureModule"
            captureModule.start()
        }

        onShowSlideShow: mainview.state = "SlideShow"

        onShowAppSettings: {
            console.log("Screen AppSettings")
            mainview.state = "SlideShow"
        }

    }

    CaptureModule {
        id: captureModule
        anchors.fill: parent
        visible: mainview.state == "CaptureModule"
    }


    Camera {
        id: camera
        captureMode: Camera.CaptureStillImage

        imageCapture {
            onImageCaptured: {
//                photoPreview.source = preview
//                stillControls.previewAvailable = true
//                cameraUI.state = "PhotoPreview"
            }
        }

        videoRecorder {
             resolution: "640x480"
             frameRate: 30
        }
    }


//    Instantiator {
//        model : ["-Black", "-BlackItalic", "-Bold", "-BoldItalic", "-Italic", "-Light", "-LightItalic", "-Medium", "-MediumItalic", "-Regular", "-Thin", "-ThinItalic"]

//        FontLoader { source: "qrc:/fonts/fonts/Roboto" + modelData + ".ttf" }
//    }

    /*
    state: "SlideShow"

    states: [
        State {
            name: "SlideShow"

            StateChangeScript {
                name: "test"
                script: slideShow.magic()
            }
        },

        State {
            name: "ModeSelection"
        }

    ]




    SlideShow {
        id: slideShow
        anchors.fill: parent

        Material.background: Material.Grey

        visible: photoBoothUi.state == "SlideShow"
        onShowModeSelection: photoBoothUi.state = "ModeSelection"
    }

    ModeSelection {
        id: modeSelection
        anchors.fill: parent
        visible:  photoBoothUi.state == "ModeSelection"
    }

*/
}

