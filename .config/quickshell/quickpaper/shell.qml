import QtQuick
import Quickshell

ShellRoot {
    Variants {
        model: Quickshell.screens
        Variants {
            required property ShellScreen modelData
            model: [
                {
                    screen: modelData,
                    context: "desktop",
                    filename: "default.png"
                },
                {
                    screen: modelData,
                    context: "overview",
                    filename: "blurred.png"
                }
            ]
            WallpaperWindow {
                required property var modelData
                screen: modelData.screen
                context: modelData.context
                filename: modelData.filename
                directory: Quickshell.env("HOME") + "/.config/wallpapers/"
            }
        }
    }
}
