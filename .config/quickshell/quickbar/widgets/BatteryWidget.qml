import Quickshell.Services.UPower

Widget {
    readonly property int percentage: Math.round(UPower.displayDevice?.percentage * 100) ?? 0
    readonly property bool discharging: UPower.displayDevice?.state === UPowerDeviceState.Discharging ?? false
    content: percentage.toString().padStart(2, "0") + " " + getIcon(percentage, discharging)
    foregroundColor: getColor(percentage, discharging)
    function getIcon(percentage, discharging) {
        if (!discharging) return "󰂄"
        if (percentage >= 90) return "󰂂"
        if (percentage >= 80) return "󰂁"
        if (percentage >= 70) return "󰂀"
        if (percentage >= 60) return "󰁿"
        if (percentage >= 50) return "󰁾"
        if (percentage >= 40) return "󰁽"
        if (percentage >= 30) return "󰁼"
        if (percentage >= 20) return "󰁻"
        if (percentage >= 10) return "󰁺"
        return "󰂃"
    }
    function getColor(percentage, discharging) {
        if (!discharging) return "#a3be8c"
        if (percentage <= 25) return "#bf616a"
        return "#d8dee9"
    }
}
