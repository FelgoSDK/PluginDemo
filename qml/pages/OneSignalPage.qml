import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "../helper"

ListPage {

  title: "OneSignal Plugin"

  model: ListModel {
    id: listModel
    ListElement { section: "Notifications"; name: "Enable notifications"; clickable: true }
    ListElement { section: "Notifications"; name: "Disable notifications"; clickable: true }

    ListElement { section: "Tags"; name: "Set tag"; clickable: true }
    ListElement { section: "Tags"; name: "Remove tag"; clickable: true }
    ListElement { section: "Tags"; name: "Request tags"; clickable: true }
    ListElement { section: "Tags"; name: "Current tags: tags not yet requested"; clickable: false }
  }

  delegate: SimpleRow {
    id: row
    text: name

    property bool isSelected: index === 0 && onesignal.enabled || index === 1 && !onesignal.enabled
    enabled: clickable === undefined || clickable

    Icon {
      anchors.right: parent.right
      anchors.rightMargin: dp(10)
      anchors.verticalCenter: parent.verticalCenter
      icon: IconType.check
      size: dp(14)
      color: row.style.textColor
      visible: isSelected
    }

    style.showDisclosure: false

    onSelected: {
      if (index === 0) {
        onesignal.enabled = true
      }
      else if (index === 1) {
        onesignal.enabled = false
      }
      else if (index === 2) {
        onesignal.sendTag("group", "test")
        listModel.setProperty(5, "name", "Current tags: please request tags")
      }
      else if (index === 3) {
        onesignal.deleteTag("group")
        listModel.setProperty(5, "name", "Current tags: please request tags")
      }
      else if (index === 4) {
        onesignal.requestTags()
        listModel.setProperty(5, "name", "Current tags: requesting tags ...")
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  // react to onTagsReceived signal to display tags
  Connections {
    target: onesignal
    onTagsReceived: {
      var tagStr = ""
      for(var tag in tags)
        tagStr += tag + " = " +tags[tag]

      if(tagStr != "")
        tagStr = "Current tags: "+tagStr
      else
        tagStr = "Current tags: no tags set"

      listModel.setProperty(5, "name", tagStr)
    }
  }
}
