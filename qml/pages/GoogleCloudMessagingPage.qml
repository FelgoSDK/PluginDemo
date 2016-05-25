import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "../helper"

ListPage {

  title: "GCM Plugin"

  model: ListModel {
    id: listModel
    ListElement { section: "Notifications"; name: "Enable notifications"; clickable: true }
    ListElement { section: "Notifications"; name: "Disable notifications"; clickable: true }

    ListElement { section: "Channels"; name: "Set channel"; clickable: true }
    ListElement { section: "Channels"; name: "Remove channel"; clickable: true }
    ListElement { section: "Channels"; name: "Current channels:"; clickable: false }
  }

  delegate: SimpleRow {
    id: row
    text: name

    property bool isSelected: index === 0 && gcm.enabled || index === 1 && !gcm.enabled
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
        gcm.enabled = true
      }
      else if (index === 1) {
        gcm.enabled = false
      }
      else if (index === 2) {
        gcm.channels = [ "test" ]
      }
      else if (index === 3) {
        gcm.channels = []
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  Component.onCompleted: {
    updateChannelString()
  }

  function updateChannelString() {
    var str = "Current channels: " + (gcm.channels.length > 0 ? gcm.channels.join(", ") : "no channels set")
    listModel.setProperty(4, "name", str)
  }


}
