import Quickshell
import Quickshell.Io

Scope {
    id: root
    required property string ticker
    property real price: 0.00
    property real change: 0.00
    Process {
        command: ["sh", "-c", "uv run --directory ~/.config/quickshell/quickbar/scripts/ stock.py " + root.ticker]
        running: true
        stdout: SplitParser {
            onRead: message => {
                if (message === "") {
                    root.price = 0.00
                    root.change = 0.00
                    return
                }
                const [price, change] = message.split(",")
                root.price = parseFloat(price)
                root.change = parseFloat(change)
            }
        }
    }
}
