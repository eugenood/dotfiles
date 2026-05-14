import ".."
import "../models"

BaseTextPresenter {
    readonly property BatteryModel model: BatteryModel {}
    readonly property int percentage: model.percentage
    readonly property bool discharging: model.discharging
    content: percentage.toString().padStart(2, "0") + " " + getIcon(percentage, discharging)
    contentColor: getColor(percentage, discharging)
    function getIcon(percentage, discharging) {
        if (!discharging) return "󰂄"
        if (percentage >= 95) return "󰁹"
        if (percentage >= 85) return "󰂂"
        if (percentage >= 75) return "󰂁"
        if (percentage >= 65) return "󰂀"
        if (percentage >= 55) return "󰁿"
        if (percentage >= 45) return "󰁾"
        if (percentage >= 35) return "󰁽"
        if (percentage >= 25) return "󰁼"
        if (percentage >= 15) return "󰁻"
        if (percentage >= 05) return "󰁺"
        return "󰂃"
    }
    function getColor(percentage, discharging) {
        if (!discharging) return Colors.green
        if (percentage < 25) return Colors.red
        return Colors.foreground
    }
}
