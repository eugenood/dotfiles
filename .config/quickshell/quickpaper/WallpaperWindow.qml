// qmllint disable

import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root
    required property string context
    required property string filename
    required property string directory
    WlrLayershell.namespace: "quickpaper-" + context
    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.exclusiveZone: -1
    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true
    Image {
        anchors.fill: parent
        source: root.directory + root.filename
        fillMode: Image.PreserveAspectCrop
    }
}
