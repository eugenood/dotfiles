import Quickshell.Hyprland

Widget {
    content: "󰣇 " + Hyprland.focusedWorkspace?.name ?? ""
    foregroundColor: "#88c0d0"
}
