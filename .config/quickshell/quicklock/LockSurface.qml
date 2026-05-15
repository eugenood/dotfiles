pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import Quickshell

Rectangle {
    id: root
    required property LockContext context
    required property color normalBackgroundColor
    required property color failureBackgroundColor
    required property color foregroundColor
    readonly property color backgroundColor: root.context.showFailure ? failureBackgroundColor : normalBackgroundColor
    color: backgroundColor
    Text {
        id: clockText
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -64
        text: Qt.formatDateTime(clock.date, "hh:mm")
        renderTypeQuality: Text.HighRenderTypeQuality
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 256
        font.bold: true
        color: root.foregroundColor
        layer.enabled: true
        layer.effect: MultiEffect {
            blurEnabled: true
            blur: root.lerp(0.8, 0.0, passwordInput.length, 8)
        }
        SystemClock {
            id: clock
            precision: SystemClock.Seconds
        }
    }
    Text {
        anchors.bottom: clockText.top
        anchors.horizontalCenter: clockText.horizontalCenter
        text: passwordInput.length == 0 ? "" : "·".repeat(passwordInput.length)
        renderTypeQuality: Text.HighRenderTypeQuality
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 64
        color: root.foregroundColor
    }
    Image {
        anchors.fill: parent
        source: "assets/main.png"
        layer.enabled: true
        layer.effect: MultiEffect {
            blurEnabled: true
            blur: root.lerp(0.0, 0.8, passwordInput.length, 10)
            colorization: 0.25
            colorizationColor: root.backgroundColor
        }
    }
    TextInput {
        id: passwordInput
        visible: false
        focus: true
        enabled: !root.context.unlockInProgress
        inputMethodHints: Qt.ImhSensitiveData
        echoMode: TextInput.Password
        onTextChanged: root.context.currentText = this.text
        onAccepted: root.context.tryUnlock()
        Connections {
            target: root.context
            function onCurrentTextChanged() {
                passwordInput.text = root.context.currentText
            }
        }
    }
    function lerp(from, to, length, maxLength) {
        const prop = Math.min(1.0, length / maxLength)
        return (1.0 - prop) * from + prop * to
    }
}
