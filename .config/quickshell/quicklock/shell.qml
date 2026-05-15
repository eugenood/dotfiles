pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
    LockContext {
        id: lockContext
        onUnlocked: {
            lock.locked = false
            Qt.quit()
        }
    }
    WlSessionLock {
        id: lock
        locked: true
        WlSessionLockSurface {
            LockSurface {
                anchors.fill: parent
                context: lockContext
                normalBackgroundColor: "#425047"
                failureBackgroundColor: "#514045"
                foregroundColor: "#d3c6aa"
            }
        }
    }
}
