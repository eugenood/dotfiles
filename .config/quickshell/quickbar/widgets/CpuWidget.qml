import QtQuick
import Quickshell.Io

Widget {
    id: root
    property int percentage
    content: percentage.toString().padStart(2, "0") + " "
    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: updateCpu.running = true
    }
    Process {
        id: updateCpu
        command: ["sh", "-c", "vmstat 1 2 | tail -1 | awk '{print 100 - $15}'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.percentage = this.text
            }
        }
    }
}
