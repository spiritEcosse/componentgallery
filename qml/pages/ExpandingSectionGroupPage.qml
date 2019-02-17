import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    SilicaFlickable {
        id: silicaFlickable
        anchors.fill: parent
        width: parent.width
//        contentHeight: silicaFlickableContent.height
        VerticalScrollDecorator {}

        PullDownMenu {
            id: pullDownMenu
            MenuItem {
                text: "Jump to the end"
                onClicked: silicaFlickableContent.scrollToBottom()
            }
            MenuLabel {
                text: "Menu label"
            }
        }

//        Need a fix.
//        Does not work correctly, because:
//        QML SilicaFlickable (silicaFlickable) : Binding loop detected for property "contentHeight"
//        PushUpMenu {
//            id: pushUpMenu
//            spacing: Theme.paddingLarge
//            MenuItem {
//                text: "Return to Top"
//                onClicked: silicaFlickableContent.scrollToTop()
//            }
//        }

        FlippingPageHeader {
            id: header
            animate: page.status === PageStatus.Active
            width: parent.width
            title: sectionPr + subSectionPr
            property string sectionPr: "sectionPr"
            property string subSectionPr: " subSectionPr"
            onSectionPrChanged: subSectionPr = ""
        }

        Image {
            width: parent.width
            height: header.height
            source: "image://theme/graphic-gradient-edge"
            rotation: 180
        }

        SilicaFlickable {
            id: silicaFlickableContent
            width: parent.width
            contentHeight: expandGroup.height
            clip: true
            anchors {
                left: parent.left
                right: parent.right
                top: header.bottom
                bottom: parent.bottom
            }

            ExpandingSectionGroupEx {
                id: expandGroup
                onCurrentSectionChanged: {
                    header.sectionPr = currentSection ? currentSection.title : ""
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
                                id: expandGroupSub
                                onCurrentSectionChanged: {
                                    header.subSectionPr = currentSection ? " sub " + currentSection.title : ""
                                }

                                Repeater {
                                    model: (section.sectionIndex + 1) * 2

                                    ExpandingSection {
                                        id: sectionS
                                        title: model.index + 1
                                        property int sectionIndex: model.index

                                        content.sourceComponent: Column {
                                            width: sectionS.width
                                            spacing: 20

                                            Repeater {
                                                model: sectionS.sectionIndex

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
