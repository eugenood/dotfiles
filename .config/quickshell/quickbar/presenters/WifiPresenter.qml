import ".."
import "../models"

BaseTextPresenter {
    id: root
    readonly property WifiModel model: WifiModel {}
    readonly property bool connected: model.connected
    readonly property string ssid: model.ssid
    content: ssid + " " + getIcon(connected)
    contentColor: getColor(connected)
    function getIcon(connected) {
        if (connected) return "󰤨"
        return "󰤭"
    }
    function getColor(connected) {
        if (connected) return Colors.foreground
        return Colors.red
    }
}
