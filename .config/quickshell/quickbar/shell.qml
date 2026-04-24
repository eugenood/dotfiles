import QtQuick.Layouts
import Quickshell

import "widgets"

Variants {
    model: Quickshell.screens
    PanelWindow {
        required property ShellScreen modelData
        screen: modelData
        anchors.top: true
        anchors.left: true
        anchors.right: true
        margins.top: 4
        margins.left: 4
        margins.right: 4
        implicitHeight: layout.implicitHeight
        color: "transparent"
        RowLayout {
            id: layout
            anchors.fill: parent
            WorkspaceWidget {}
            TitleWidget {}
            BrightnessWidget {}
            VolumeWidget {}
            StockWidget { ticker: "VWRA.L" }
            WeatherWidget { areaName: "Paya Lebar" }
            WifiWidget {}
            CpuWidget {}
            BatteryWidget {}
            DateWidget {}
            TimeWidget {}
        }
    }
}
