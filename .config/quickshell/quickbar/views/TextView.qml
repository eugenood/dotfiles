import QtQuick

import "../presenters"

Text {
    required default property BaseTextPresenter presenter
    text: presenter.content
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: parent.height / 2
    verticalAlignment: Text.AlignVCenter
    color: presenter.contentColor
}
