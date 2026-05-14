import "../models"

BaseTextPresenter {
    readonly property DateTimeModel model: DateTimeModel {}
    readonly property string date: model.date
    content: date
}
