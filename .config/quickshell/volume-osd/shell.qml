pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
    id: root
    property bool visible: false
    property int percentage
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    Connections {
        target: Pipewire.defaultAudioSink?.audio
        function onVolumeChanged() {
            root.visible = true
            root.percentage = Pipewire.defaultAudioSink?.audio.volume * 100
            hideTimer.restart()
        }
    }
    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.visible = false
    }
    LazyLoader {
        active: root.visible
        PanelWindow {
            anchors.right: true
            anchors.top: true
            margins.right: 20
            margins.top: 20
            implicitWidth: 10
            implicitHeight: 200
            exclusiveZone: 0
            color: "transparent"
            ClippingRectangle {
                anchors.fill: parent
                radius: 4
                color: "#3b4252"
                Rectangle {
                    anchors.bottom: parent.bottom
                    width: parent.height
                    height: parent.height * (root.percentage / 100)
                    color: "#88c0d0"
                }
            }
        }
    }
}
