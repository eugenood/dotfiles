import ".."
import "../models"

BaseTextPresenter {
    id: root
    required property string ticker
    readonly property StockModel model: StockModel { ticker: root.ticker }
    readonly property real price: model.price
    readonly property real change: model.change
    content: ticker + " " + price.toFixed(2)
    contentColor: getColor(change)
    function getColor(change) {
        if (change > 0) return Colors.green
        if (change < 0) return Colors.red
        return Colors.foreground
    }
}
