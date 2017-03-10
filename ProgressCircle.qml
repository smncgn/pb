import QtQuick 2.7

Item {
    id: root

    width: size
    height: size

    property int size: 200      // Kreisdurchmesser in px
    property real arcBegin: 0   // Startwinkel in Grad
    property real arcEnd: 270   // Endwinkel in Grad
    property real arcOffset: 0  // Rotation
    property bool showBackground: false  // Hintergrund darstellen
    property real lineWidth: 20
    property string colorCircle: "#607D8B"  // Material BlueGrey
    property string colorBackground: "#FAFAFA"

    property alias beginAnimation: animationArcBegin.enabled
    property alias endAnimation: animationArcEnd.enabled

    property int animationDuration: 200

    onArcBeginChanged: canvas.requestPaint()
    onArcEndChanged: canvas.requestPaint()

    Behavior on arcBegin {
        id: animationArcBegin
        enabled: true
        NumberAnimation {
            duration: root.animationDuration
            easing.type: Easing.InOutCubic
        }
    }

    Behavior on arcEnd {
        id: animationArcEnd
        enabled: true
        NumberAnimation {
            duration: root.animationDuration
            easing.type: Easing.Linear
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent
        rotation: -90 + parent.arcOffset

        onPaint: {
            var ctx = getContext("2d")
            var x = width / 2
            var y = height / 2
            var start = Math.PI * (parent.arcBegin / 180)
            var end = Math.PI * (parent.arcEnd / 180)
            ctx.reset()

            if(root.showBackground){
                ctx.beginPath();
                ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, 0, Math.PI * 2, false)
                ctx.lineWidth = root.lineWidth
                ctx.strokeStyle = root.colorBackground
                ctx.stroke()
            }

            ctx.beginPath()
            ctx.arc(x, y, (width / 2) - parent.lineWidth / 2, start, end, false)
            ctx.lineWidth = root.lineWidth
            ctx.strokeStyle = root.colorCircle
            ctx.stroke()

        }
    }
}
