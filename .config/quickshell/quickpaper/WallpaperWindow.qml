// qmllint disable

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root
    required property string context
    required property string imageSource
    required property color backgroundColor
    required property color foregroundColor
    required property bool imageBlurEnabled
    required property bool clockBlurEnabled
    required property bool clockEnabled
    WlrLayershell.namespace: "quickpaper-" + context
    WlrLayershell.layer: WlrLayer.Background
    exclusionMode: ExclusionMode.Ignore
    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true
    color: backgroundColor
    Component {
        id: clockComponent
        Item {
            anchors.fill: parent
            Text {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -64
                text: Qt.formatDateTime(clock.date, "hh:mm")
                renderTypeQuality: Text.VeryHighRenderTypeQuality
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 256
                font.bold: true
                color: root.foregroundColor
                layer.enabled: true
                layer.effect: MultiEffect {
                    blurEnabled: root.clockBlurEnabled
                    blur: 0.8
                }
                SystemClock {
                    id: clock
                    precision: SystemClock.Seconds
                }
            }
        }
    }
    Loader {
        active: root.clockEnabled
        anchors.fill: parent
        sourceComponent: clockComponent
    }
    Image {
        source: root.imageSource
        sourceSize.width: parent.width
        anchors.bottom: parent.bottom
        fillMode: Image.FillMode.PreserveAspectFit
        layer.enabled: true
        layer.effect: MultiEffect {
            blurEnabled: root.imageBlurEnabled
            blur: 0.8
            colorization: 0.25
            colorizationColor: root.backgroundColor
        }
    }
}
