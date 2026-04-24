pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

Scope {
    id: root
    property bool visible: false
    property int percentage
    Process {
        command: ["sh", "-c", "udevadm monitor --subsystem-match=backlight --udev"]
        running: true
        stdout: SplitParser {
            onRead: updateBrightness.running = true
        }
    }
    Process {
        id: updateBrightness
        command: ["sh", "-c", "brightnessctl -m"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.visible = true
                root.percentage = this.text.split(",")[3].replace("%", "")
                hideTimer.restart()
            }
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
                    width: parent.width
                    height: parent.height * (root.percentage / 100)
                    color: "#88c0d0"
                }
            }
        }
    }
}
