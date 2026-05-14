import Quickshell
import Quickshell.Services.UPower

Scope {
    property int percentage: Math.round(UPower.displayDevice?.percentage * 100) ?? 0
    property bool discharging: UPower.displayDevice?.state === UPowerDeviceState.Discharging ?? false
}
