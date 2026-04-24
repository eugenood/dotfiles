import Quickshell.Io

Widget {
    id: root
    property string device: "wlan0"
    property bool connected
    property string ssid
    content: ssid + " " + getIcon(connected)
    foregroundColor: getColor(connected)
    Process {
        command: ["sh", "-c", "ip monitor link dev " + root.device]
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
    function getIcon(connected) {
        if (connected) return "󰤨"
        return "󰤭"
    }
    function getColor(connected) {
        if (connected) return "#d8dee9"
        return "#bf616a"
    }
}
