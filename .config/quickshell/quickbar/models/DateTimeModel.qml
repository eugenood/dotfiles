import QtQuick
import Quickshell

Scope {
    property string date: Qt.formatDateTime(clock.date, "dd/MM ddd")
    property string time: Qt.formatDateTime(clock.date, "hh:mm:ss")
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
