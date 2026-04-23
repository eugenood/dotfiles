import QtQuick
import Quickshell.Io

Widget {
    id: root
    property int percentage
    content: percentage.toString().padStart(2, "0") + " 󰃠"
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
                root.percentage = this.text.split(",")[3].replace("%", "")
            }
        }
    }
}
