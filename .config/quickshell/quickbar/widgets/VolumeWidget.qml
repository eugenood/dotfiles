import Quickshell.Services.Pipewire

Widget {
    readonly property int percentage: Math.round(Pipewire.defaultAudioSink?.audio.volume * 100) ?? 0
    readonly property bool muted: Pipewire.defaultAudioSink?.audio.muted ?? true
    content: percentage.toString().padStart(2, "0") + " " + getIcon(percentage, muted)
    foregroundColor: getColor(muted)
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    function getIcon(percentage, discharging) {
        if (muted) return ""
        if (percentage == 100) return ""
        if (percentage >= 10) return ""
        return ""
    }
    function getColor(muted) {
        if (muted) return "#bf616a"
        return "#d8dee9"
    }
}
