import Quickshell

Widget {
    content: Qt.formatDateTime(clock.date, "hh:mm:ss")
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
