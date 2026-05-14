import ".."
import "../models"

BaseTextPresenter {
    readonly property VolumeModel model: VolumeModel {}
    readonly property int percentage: model.percentage
    readonly property bool muted: model.muted
    content: percentage.toString().padStart(2, "0") + " " + getIcon(percentage, muted)
    contentColor: getColor(muted)
    function getIcon(percentage, discharging) {
        if (muted) return ""
        if (percentage == 100) return ""
        if (percentage >= 10) return ""
        return ""
    }
    function getColor(muted) {
        if (muted) return Colors.red
        return Colors.foreground
    }
}
