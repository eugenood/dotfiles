// qmllint disable

import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "./presenters"
import "./views"

ShellRoot {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property ShellScreen modelData
            WlrLayershell.namespace: "quickbar"
            screen: modelData
            anchors.top: true
            margins.top: 8
            implicitWidth: layout.implicitWidth
            implicitHeight: 24
            color: "transparent"
            RowLayout {
                id: layout
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                spacing: 8
                Pill {
                    TextView { StockPresenter { ticker: "IB01.L" } }
                    TextView { StockPresenter { ticker: "VWRA.L" } }
                }
                Pill {
                    TextView { WifiPresenter {} }
                }
                Pill {
                    TextView { BrightnessPresenter {} }
                    TextView { VolumePresenter {} }
                }
                Pill {
                    TextView { CpuPresenter {} }
                    TextView { BatteryPresenter {} }
                }
                Pill {
                    TextView { DatePresenter {} }
                    TextView { TimePresenter {} }
                }
            }
        }
    }
}
