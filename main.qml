import QtQuick 2.14
import QtQuick.Window 2.14

import QtQuick.Timeline 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Rectangle {
        id: rect1
        x: 0
        y: 0
        width: 50
        height: 50

        color: "#800000"
        onXChanged: print("Rect1 x changed to " + x)
    }

    Rectangle {
        id: rect2
        x: 0
        y: 100
        width: 50
        height: 50

        color: "#008000"
        onXChanged: print("Rec21 x changed to " + x)
    }

    Timeline {
        id: timeline
        endFrame: 100
        startFrame: 0

        enabled: false

        onCurrentFrameChanged: print("timeline currentFrame is " + currentFrame)

        keyframeGroups: [
            KeyframeGroup { target: rect1; property: "x";
                Keyframe { frame: 0; value: 0 }
                Keyframe { frame: 50; value: 50 }
                Keyframe { frame: 100; value: 200 }
            },
            KeyframeGroup { target: rect2; property: "x" ;
                Keyframe { frame: 0; value: 0 }
                Keyframe { frame: 50; value: 100}
                Keyframe { frame: 100; value: 200 }
            }
        ]

        animations: [
            TimelineAnimation  {pingPong: false; duration: 1000; from: 0; to: 100; running: false; id: xAnimation}
        ]
    }

    Component.onCompleted: {
        print ("timeline enabled is : " + timeline.enabled)
        print ("timeline startFrame and endFrame are " + timeline.startFrame + ", " + timeline.endFrame)

        timeline.enabled = true;
        print ("timeline is now enabled")

        xAnimation.restart()
    }
}
