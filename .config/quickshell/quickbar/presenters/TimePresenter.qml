import "../models"

BaseTextPresenter {
    readonly property DateTimeModel model: DateTimeModel {}
    readonly property string time: model.time
    content: time
}
