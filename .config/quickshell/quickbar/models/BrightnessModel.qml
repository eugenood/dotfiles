import Quickshell
import Quickshell.Io

Scope {
    id: root
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
                root.percentage = this.text.split(",")[3].replace("%", "")
            }
        }
    }
}
