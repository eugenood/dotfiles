import "../models"

BaseTextPresenter {
    readonly property BrightnessModel model: BrightnessModel {}
    readonly property int percentage: model.percentage
    content: percentage.toString().padStart(2, "0") + " 󰃠"
}
