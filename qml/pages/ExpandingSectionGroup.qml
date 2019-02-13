import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    SilicaFlickable {
        id: silicaFlickable
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        PullDownMenu {
            id: pullDownMenu
            MenuItem {
                text: "Jump to the end"
                onClicked: silicaFlickable.scrollToBottom()
            }
            MenuLabel {
                text: "Menu label"
            }
        }
        PushUpMenu {
            id: pushUpMenu
            spacing: Theme.paddingLarge
            MenuItem {
                text: "Return to Top"
                onClicked: silicaFlickable.scrollToTop()
            }
        }

        Column {
            id: column
            spacing: Theme.paddingLarge
            width: parent.width

            PageHeader {
                id: header
                title: "ExpandingSectionGroup"
            }

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
                    var headerH = header.height + Theme.paddingMedium
                    var expGrY = currentIndex * newSection.buttonHeight + Theme.paddingMedium
                    contentYAnimation.to = expGrY + headerH - absY
                    contentYAnimation.start()
                }

                NumberAnimation {
                    id: contentYAnimation
                    target: expandGroup._flickable
                    property: "contentY"
                    duration: expandGroup.animationDuration
                }

                Repeater {
                    model: 100

                    ExpandingSection {
                        id: section

                        property int sectionIndex: model.index
                        title: "Section " + index
                        content.sourceComponent: Column {
                            width: section.width

                            ExpandingSectionGroup {
                                Repeater {
                                    model: (section.sectionIndex + 1) * 2

                                    ExpandingSection {
                                        id: sectionS
                                        title: "sub " + (model.index + 1)

                                        content.sourceComponent: Column {
                                            width: sectionS.width
                                            spacing: 20

                                            Repeater {
                                                model: 5

                                                Button {
                                                    width: parent.width
                                                    color: Theme.highlightColor

                                                    Label {
                                                        anchors.centerIn: parent
                                                        text: "Text " + index
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}