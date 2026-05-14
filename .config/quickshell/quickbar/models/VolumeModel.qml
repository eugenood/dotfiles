import Quickshell
import Quickshell.Services.Pipewire

Scope {
    property int percentage: Math.round(Pipewire.defaultAudioSink?.audio.volume * 100) ?? 0
    property bool muted: Pipewire.defaultAudioSink?.audio.muted ?? true
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
}
