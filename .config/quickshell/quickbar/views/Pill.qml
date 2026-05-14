import QtQuick.Layouts
import Quickshell.Widgets

import ".."

WrapperRectangle {
    id: root
    default property list<TextView> views
    Layout.fillHeight: true
    leftMargin: height / 2
    rightMargin: height / 2
    radius: height / 2
    color: Colors.background
    RowLayout {
        id: layout
        height: parent.height
        spacing: 16
        data: root.views
    }
}

