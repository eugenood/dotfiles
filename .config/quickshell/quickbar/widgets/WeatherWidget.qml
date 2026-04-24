import QtQuick
import Quickshell.Io

Widget {
    id: root
    required property string areaName
    property string forecast
    property string icon
    content: forecast + " " + icon
    Process {
        command: ["sh", "-c", "uv run --directory ~/.config/quickshell/quickbar/scripts/ weather.py '" + root.areaName + "'"]
        running: true
        stdout: SplitParser {
            onRead: message => {
                if (message === "") {
                    root.forecast = ""
                    root.icon = ""
                    root.visible = false
                    return
                }
                root.forecast = message
                root.icon = "󰖐"
                if (message.includes("Rain") || message.includes("Shower")) {
                    root.icon = "󰖖"
                    root.foregroundColor = "#bf616a"
                } else {
                    root.icon = "󰖐"
                    root.foregroundColor = "#d8dee9"
                }
                root.visible = true
            }
        }
    }
}
