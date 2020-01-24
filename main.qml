import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14

import QtQuick.Timeline 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Qml Timeline Demo")

    Rectangle {
        id: rect1
        x: 0
        y: 25
        width: 50
        height: 50

        color: "#800000"
        onXChanged: print("Rect1 x changed to " + x)

        MouseArea {
            anchors.fill: parent

            onClicked: {
                if (xPositionAnimation.running)
                    xPositionAnimation.stop();
                else
                    xPositionAnimation.start();
            }
        }
    }

    Rectangle {
        id: rect2
        x: 0
        y: 125
        width: 50
        height: 50

        color: "#008000"
        onXChanged: print("Rec21 x changed to " + x)

        MouseArea {
            anchors.fill: parent

            property bool increasing: true;

            onClicked: {
                if (!xPositionAnimation.running) {
                    if (increasing) {
                        timeline.currentFrame = timeline.currentFrame + 10;

                        if (timeline.currentFrame >= timeline.endFrame) {
                            increasing = false;
                        }
                    }
                    else {
                        timeline.currentFrame = timeline.currentFrame - 10;

                        if (timeline.currentFrame <= timeline.startFrame) {
                            increasing = true;
                        }
                    }

                }
            }
        }
    }

    ProgressBar {
        id: progressBar
        x:5
        y: 200
        width: parent.width - 25;
        height: 10

        from: timeline.startFrame
        to: timeline.endFrame

        value: timeline.currentFrame
    }

    Timeline {
        id: timeline
        endFrame: 100
        startFrame: 0

        enabled: true

        onCurrentFrameChanged: print("timeline currentFrame is " + currentFrame)

        keyframeGroups: [
            KeyframeGroup { target: rect1; property: "x";
                Keyframe { frame: 0; value: 0 }
                Keyframe { frame: 50; value: 100 }
                Keyframe { frame: 100; value: 400 }
            },
            KeyframeGroup { target: rect2; property: "x" ;
                Keyframe { frame: 0; value: 0 }
                Keyframe { frame: 50; value: 300}
                Keyframe { frame: 100; value: 400 }
            }
        ]

        animations: [
            TimelineAnimation  {pingPong: true; duration: 1000; from: 0; to: 100; running: false; id: xPositionAnimation}
        ]
    }
}
