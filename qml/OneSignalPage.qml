import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0

ListPage {

  title: "OneSignal Plugin"

  model: ListModel {
    ListElement { section: "Notifications"; name: "Enable notifications" }
    ListElement { section: "Notifications"; name: "Disable notifications" }

    ListElement { section: "Tags"; name: "Set tag" }
    ListElement { section: "Tags"; name: "Remove tag" }
  }

  delegate: SimpleRow {
    text: name

    onSelected: {
      if (index === 0) {
         onesignal.enabled = true
       }
      else if (index === 1) {
        onesignal.enabled = false
      }
      else if (index === 2) {
        onesignal.sendTag("group", "test")
      }
     else if (index === 3) {
       onesignal.deleteTag("group")
     }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  OneSignal {
    id: onesignal

    logLevel: OneSignal.LogLevelInfo
    appId: Constants.oneSignalAppId
    googleProjectNumber: Constants.oneSignalGoogleProjectNumber

    onNotificationReceived: {
      console.debug("Received notification:", message, JSON.stringify(additionalData), isActive)

      // Possible actions:
      // - Read message from data payload and display a user dialog
      // - Navigate to a specific screen
      // - ...
    }

    onUserIdChanged: {
      console.debug("Got OneSignal user id:", userId)
    }
  }
}
