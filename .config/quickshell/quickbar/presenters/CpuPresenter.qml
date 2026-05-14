import "../models"

BaseTextPresenter {
    readonly property CpuModel model: CpuModel {}
    readonly property int percentage: model.percentage
    content: percentage.toString().padStart(2, "0") + " "
}
