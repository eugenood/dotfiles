import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Rectangle {
    id: root
    required property LockContext context
    Image {
        anchors.fill: parent
        source: Quickshell.env("HOME") + "/.config/wallpapers/blurred.png"
    }
    WrapperRectangle {
        anchors.centerIn: parent
        margin: 32
        radius: 16
        color: root.context.showFailure ? "#514045" : "#2d353b"
        RowLayout {
            Text {
                id: passwordRenderer
                readonly property int passwordLength: Math.min(passwordInput.text.length, 30)
                readonly property string passwordLine: "password = '" + "0".repeat(passwordLength) + "'\n"
                readonly property string saltLine: "salt = 'iusearchbtw'\n"
                readonly property string targetLine: "target = 'b25a0600414ffad22e84fa5d4c1740f9'\n"
                readonly property string validateLine: "if md5(password + salt) == target:\n    unlock_screen()"
                font.family: "JetBrainsMonoNL Nerd Font"
                font.pointSize: 12
                color: "#d3c6aa"
                text: passwordLine + targetLine + saltLine + "\n" + validateLine
            }
            TextInput {
                id: passwordInput
                visible: false
                focus: true
                enabled: !root.context.unlockInProgress
                inputMethodHints: Qt.ImhSensitiveData
                onTextChanged: root.context.currentText = this.text
                onAccepted: root.context.tryUnlock()
                Connections {
                    target: root.context
                    function onCurrentTextChanged() {
                        passwordInput.text = root.context.currentText
                    }
                }
            }
        }
    }
}
