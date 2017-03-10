import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls.Material 2.1
import Qt.labs.folderlistmodel 2.1

Page {
    // Anzeigedauer eines Bilds in ms
    property int slide_duration: 6000
    // Ueberblendedauer in ms
    property int fade_duration: 800
    // Aktuelles Bild
    property variant current_image: image_1
    // Signal zum Anzeigen des Auswahlbildschirms
    signal showModeSelection

    // Bool Pause
    property bool isPaused: false

    id: root
    focus: true


    Timer {
        id: new_timer
        interval: 5
        repeat: false
        triggeredOnStart: false
        onTriggered: letTheShowBegin()
    }

    function startOver(){
        if(isPaused){
            console.log("weiter geht's")
            isPaused = false;
            main_timer.start();
        } else
            new_timer.start();
    }

    Component.onCompleted: startOver()

    function letTheShowBegin(){
        if(mymodel.count > 0)
            mymodel.startTheShow()
        else
            startOver()
    }



    // 2 Slides laden
    Loader {id: image_1; transformOrigin: Item.TopLeft; sourceComponent: slide;}
    Loader {id: image_2; transformOrigin: Item.TopLeft; sourceComponent: slide;}


    // Bilddateien laden und vorbereiten
    FolderListModel {
        id: mymodel
        folder: "file:/ADAPT/svogt6/images/"
        nameFilters: ["*.jpg", "*.jpeg", "*.png"]
        showDirs : false

        property int index: 0
        property variant rlist: []

        function getNextUrl(){
            if(index >= rlist.length)
                shuffleList();
            return mymodel.get(rlist[index++], "fileURL"); //filePath
        }

        //Fisher-Yates shuffle algorithm.
        function shuffleArray(array) {
            for (var i = array.length - 1; i > 0; i--) {
                var j = Math.floor(Math.random() * (i + 1));
                var temp = array[i];
                array[i] = array[j];
                array[j] = temp;
            }
            return array;
        }

        function shuffleList()
        {
            console.log("Shuffle...");
            var list = [];
            for(var i=0; i<mymodel.count; i++)
                list.push(i);
            shuffleArray(list);
            rlist = list;
            index = 0;
        }



        //Initialisation
        //        onDataChanged: {
        //            console.log("dataChanged")
        //            console.log(mymodel.folder)
        //            console.log(mymodel.count+ " images found");
        //            shuffleList();
        //            //Force la lecture de la 1ere image
        //            image_1.item.asynchronous = false
        //            image_1.item.visible = true;
        //            image_1.item.load_next_slide();
        //            image_2.item.load_next_slide();

        //            image_1.item.asynchronous = true;
        //            main_timer.start();
        //        }

        function startTheShow()
        {
            console.log("startTheShow")
            console.log(mymodel.folder)
            console.log(mymodel.count+ " images found");
            shuffleList();
            //Force la lecture de la 1ere image
            image_1.item.asynchronous = false
            image_1.item.visible = true;
            image_1.item.load_next_slide();
            image_2.item.load_next_slide();

            image_1.item.asynchronous = true;
            main_timer.start();
        }
    }

    //Main timer
    Timer{
        id: main_timer
        interval: slide_duration-fade_duration
        repeat: true
        triggeredOnStart : true

        onTriggered: {
            current_image.item.fadein();
            current_image = (current_image == image_1 ? image_2 : image_1); //Swap img
            current_image.item.fadeout();
        }
    }

    // Slide Component
    Component {
        id: slide

        Image {
            id: image
            asynchronous: true
            cache: false
            fillMode: Image.PreserveAspectFit
            opacity: 0
            width: root.width
            height: root.height

            // Displaygroesse
            sourceSize.width: 800
            sourceSize.height: 480

            property real from_scale: 1
            property real to_scale: 1

            property real from_x: 0
            property real to_x: 0

            property real from_y: 0
            property real to_y: 0

            function randRange(a, b){return Math.random()*Math.abs(a-b) + Math.min(a,b);}
            function randChoice(n){return Math.round(Math.random()*(n-1));}
            function randDirection(){return (Math.random() >= 0.5) ? 1 : -1;}

            function fadein(){
                //Check image loading...
                if(status != Image.Ready){
                    console.log("LOAD ERROR", source);
                    startOver();
                    return;
                }

                //Fit in view
                var image_ratio = paintedWidth/paintedHeight;
                var scale = (height == paintedHeight) ? width/paintedWidth : height/paintedHeight;

                //Find random directions
                if(image_ratio < 1){ //Rotated
                    from_scale = scale*0.8;//Un-zoom on 16/9 viewer...
                    to_scale = from_scale;
                    from_y = 0;
                    to_y = 0;
                    from_x = randDirection()*(paintedHeight*from_scale-height)/2;
                    to_x = 0;
                }
                else if(image_ratio > 2){ //Panorama
                    from_scale = scale;
                    to_scale = from_scale;
                    from_y = randDirection()*(paintedWidth*from_scale-width)/2;
                    to_y = -from_y;
                    from_x = 0;
                    to_x = 0;
                }
                else {  //Normal
                    var type = randChoice(3);
                    switch(type)
                    {
                    case 0: //Zoom in
                        from_scale = scale;
                        to_scale = scale*1.4;
                        from_y = 0;
                        to_y = 0;
                        from_x = 0;
                        to_x = 0;
                        break;
                    case 1: //Zoom out
                        from_scale = scale*1.4;
                        to_scale = scale;
                        from_y = 0;
                        to_y = 0;
                        from_x = 0;
                        to_x = 0;
                        break;
                    default: //Fixed zoom
                        from_scale = scale*1.2;
                        to_scale = from_scale;
                        break;
                    }
                    //Random x,y
                    var from_max_y = (paintedWidth*from_scale-width)/2;
                    var to_max_y = (paintedWidth*to_scale-width)/2;
                    from_y = randRange(-from_max_y, from_max_y);
                    to_y = randRange(-to_max_y, to_max_y);

                    var from_max_x = (paintedHeight*from_scale-height)/2;
                    var to_max_x = (paintedHeight*to_scale-height)/2;
                    from_x = randRange(-from_max_x, from_max_x);
                    to_x = randRange(-to_max_x, to_max_x);
                }

                visible = true;
                afadein.start();
            }

            function fadeout(){
                afadeout.start();
            }

            function load_next_slide(){
                visible = false;
                source = mymodel.getNextUrl();
                console.log(source);
            }

            ParallelAnimation{
                id: afadein
                NumberAnimation {target: image; property: "opacity"; from: 0; to: 1; duration: fade_duration; easing.type: Easing.InOutQuad;}
                NumberAnimation {target: image; property: "y"; from: from_x; to: to_x; duration: slide_duration; }
                NumberAnimation {target: image; property: "x"; from: from_y; to: to_y; duration: slide_duration; }
                NumberAnimation {target: image; property: "scale"; from: from_scale; to: to_scale; duration: slide_duration; }
            }

            SequentialAnimation {
                id: afadeout;
                NumberAnimation{ target: image; property: "opacity"; from: 1; to: 0; duration: fade_duration; easing.type: Easing.InOutQuad;}
                ScriptAction { script: image.load_next_slide(); }
            }

        }
    }


    // Button zum Unterbrechen und zum Auswahlbildschirm zu wechseln
    Button {
        text: "Start"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10

        onClicked: {
            root.showModeSelection();
            main_timer.stop();
            isPaused = true;
        }

    }


}
