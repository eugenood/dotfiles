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
                    imageSource: "assets/main.png",
                    backgroundColor: "#425047",
                    foregroundColor: "#d3c6aa",
                    imageBlurEnabled: true,
                    clockBlurEnabled: false,
                    clockEnabled: true,
                },
                {
                    screen: modelData,
                    context: "overview",
                    imageSource: "assets/main.png",
                    backgroundColor: "#232a2e",
                    foregroundColor: "#d3c6aa",
                    imageBlurEnabled: true,
                    clockBlurEnabled: false,
                    clockEnabled: false,
                }
            ]
            WallpaperWindow {
                required property var modelData
                screen: modelData.screen
                context: modelData.context
                imageSource: modelData.imageSource
                backgroundColor: modelData.backgroundColor
                foregroundColor: modelData.foregroundColor
                imageBlurEnabled: modelData.imageBlurEnabled
                clockBlurEnabled: modelData.clockBlurEnabled
                clockEnabled: modelData.clockEnabled
            }
        }
    }
}
