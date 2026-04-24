pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import Quickshell

Scope {
    id: root
    property bool visible: false
    SystemClock {
        id: clock
        precision: SystemClock.Seconds
        onDateChanged: {
            if ((this.minutes * 60 + this.seconds) % 1800 === 0)
                root.visible = true
        }
    }
    LazyLoader {
        active: root.visible
        PanelWindow {
            id: panel
            anchors.bottom: true
            anchors.right: true
            margins.bottom: -this.implicitHeight
            margins.right: 40
            implicitWidth: image.sourceSize.width + 20
            implicitHeight: image.sourceSize.height + 20
            exclusiveZone: 0
            color: "transparent"
            Image {
                id: image
                source: "hideri.png"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                sourceSize.width: 115
                sourceSize.height: 150
                layer.enabled: true
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowColor: "#000000"
                    shadowBlur: 0.5
                    autoPaddingEnabled: true
                }
            }
            SequentialAnimation {
                id: anim
                running: true
                NumberAnimation {
                    target: panel
                    property: "margins.bottom"
                    to: 0
                    easing.type: Easing.InBounce
                }
                PauseAnimation { duration: 10000 }
                NumberAnimation {
                    target: panel
                    property: "margins.bottom"
                    to: -panel.implicitHeight
                    easing.type: Easing.OutBounce
                }
                onFinished: root.visible = false
            }
        }
    }
}

