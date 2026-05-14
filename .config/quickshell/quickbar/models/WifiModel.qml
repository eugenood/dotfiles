import Quickshell
import Quickshell.Io

Scope {
    id: root
    property string device: "wlan0"
    property string ssid
    property bool connected
    Process {
        command: ["sh", "-c", "dbus-monitor --system \"sender='net.connman.iwd'\""]
        running: true
        stdout: SplitParser {
            onRead: updateWifi.running = true
        }
    }
    Process {
        id: updateWifi
        command: ["sh", "-c", "iwctl station " + root.device + " show"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const output = this.text
                const ssidMatch = output.match(/Connected network\s+(.*)/)
                const stateMatch = output.match(/State\s+(.*)/)
                if (ssidMatch && stateMatch && stateMatch[1].trim() === "connected") {
                    root.ssid = ssidMatch[1].trim()
                    root.connected = true
                } else {
                    root.ssid = "Disconnected"
                    root.connected = false
                }
            }
        }
    }
}
