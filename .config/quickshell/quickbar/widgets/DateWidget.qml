import Quickshell

Widget {
    content: Qt.formatDateTime(clock.date, "dd/MM ddd")
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
