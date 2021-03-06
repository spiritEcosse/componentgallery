import QtQuick 2.0
import Sailfish.Silica 1.0

ExpandingSectionGroup {
    id: expandGroup

    function findFlickable(item) {
        var parentItem = item.parent
        while (parentItem) {
            if (parentItem.maximumFlickVelocity && !parentItem.hasOwnProperty('__silica_hidden_flickable')) {
                return parentItem
            }
            parentItem = parentItem.parent
        }
        return null
    }

    function _updateFlickableContentY(oldSection, newSection) {
        if (!expandGroup._flickable) {
            expandGroup._flickable = findFlickable(expandGroup)
        }
        if (!expandGroup._flickable) {
            return
        }

        var absY = newSection.mapToItem(null, 0, 0).y
        var headerH = header ? header.height : 0
        var expGrY = currentIndex * newSection.buttonHeight
        contentYAnimation.to = expGrY + headerH - absY
        contentYAnimation.start()
    }

    NumberAnimation {
        id: contentYAnimation
        target: expandGroup._flickable
        property: "contentY"
        duration: expandGroup.animationDuration
    }
}
