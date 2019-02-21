import Felgo 3.0
import QtQuick 2.0
import "../helper"

ListPage {

  title: "GCM Plugin"

  listView.header: Column {
    width: parent.width

    SectionDescription { text: "Integrate with GCM Push to increase your users' engagement." }
    SectionContent {
      contentItem: AppImage {
        width: sourceSize.width * dp(1) * 0.75
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/code-gcm.png")
      }
    }

    SectionHeader { text: "Increase Engagement" }
    SectionDescription { text: "Push notifications are a direct channel to your app's users. Keep them happy and engaged with app updates, promotions, and more sent directly to their device." }
    SectionHeader { text: "Targeted Push Notifications" }
    SectionDescription { text: "Send notifications to all users, a targeted segment or an individual user, thanks to push tags it has never been easier to send push notifications." }
    SectionContent {
      contentItem: AppImage {
        anchors.horizontalCenter: parent.horizontalCenter
        width: sourceSize.width * dp(1) * 0.5
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/logo-gcm.png")
      }
    }

//    SectionHeader { text: "Example" }
  }

//  model: ListModel {
//    id: listModel
//    ListElement { section: "Notifications"; name: "Enable notifications"; clickable: true }
//    ListElement { section: "Notifications"; name: "Disable notifications"; clickable: true }

//    ListElement { section: "Channels"; name: "Set channel"; clickable: true }
//    ListElement { section: "Channels"; name: "Remove channel"; clickable: true }
//    ListElement { section: "Channels"; name: "Current channels:"; clickable: false }
//  }

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

    // check if listModel exists, as it is commented above by default, may be removed after uncommenting the ListModel
    if(typeof (listModel) !== "undefined") {
      listModel.setProperty(4, "name", str)
    }
  }

  // Define GoogleCloudMessaging once per app in GameWindow or App root component
  GoogleCloudMessaging {
    id: gcm

    onNotificationReceived: {
      console.debug("Received notification:", JSON.stringify(data))
      // Possible actions:
      // - Read message from data payload and display a user dialog
      // - Navigate to a specific screen
      // - ...
    }

    onChannelsChanged: {
      updateChannelString()
    }
  }

}
