import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: root

    ListViewExpandingSection {
        id: listView
        model: listModel
        anchors.fill: parent

        delegate: ListItem {
            id: listItem
            width: parent.width
            height: contentHeight

            Label {
                x: Theme.horizontalPageMargin
                anchors.verticalCenter: parent.verticalCenter
                text: (model.index+1) + ". " + model.text
                font.capitalization: Font.Capitalize
                color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
            }

            Column {

                ListViewExpandingSection {
                    id: listViewSub
                    model: listModel
                    anchors.fill: parent

                    Label {
                        x: Theme.horizontalPageMargin
                        anchors.verticalCenter: parent.verticalCenter
                        text: model.index + 1
                        font.capitalization: Font.Capitalize
                        color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                }
            }
        }
    }

    ListModel {
        id: listModel
    }

    onPageContainerChanged: addItems()

    function addItems() {
        var entries = (pageContainer && pageContainer.depth % 2 == 1) ? 40 : 5
        var spaceIpsumWords = ["Since", "long", "run", "every", "planetary", "civilization", "endangered", "impacts", "space", "every", "surviving",
                               "civilization", "obliged", "become", "spacefaring", "because", "exploratory", "romantic", "zeal", "most", "practical",
                               "reason", "imaginable", "staying", "alive", "long-term", "survival", "stake", "have", "basic", "responsibility", "species",
                               "venture", "other", "worlds", "one", "small", "step", "man", "one", "giant", "leap", "mankind", "powered", "flight",
                               "total", "about", "eight", "half", "minutes", "seemed", "gone", "lash", "gone", "from", "sitting", "still", "launch",
                               "pad", "Kennedy", "Space", "Center", "traveling", "17500", "miles", "hour", "eight", "half", "minutes", "still",
                               "recall", "making", "some", "statement", "air", "ground", "radio", "benefit", "fellow", "astronauts", "who", "also",
                               "program", "long", "time", "well", "worth", "took", "been", "wait", "mind-boggling"]

        for (var index = 0; index < entries; index++) {
            listModel.append({"text": spaceIpsumWords[index*2] + " " + spaceIpsumWords[index*2+1]})
        }
        for (index = 0; index < entries; index++) {
            listModel.append({"text": spaceIpsumWords[index*2] + " " + spaceIpsumWords[index*2+1]})
        }
    }
}
