import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0

ListPage {

  title: "Parse Plugin"

  model: ListModel {
    ListElement { section: "Channels"; name: "Set channel" }
    ListElement { section: "Channels"; name: "Remove channel" }
  }

  delegate: SimpleRow {
    text: name

    onSelected: {
     if (index === 0) {
        parse.channels = [ "channel-1" ]
      }
     else if (index === 1) {
       parse.channels = []
     }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  Parse {
    id: parse

    applicationId: ""
    clientKey: ""

    onNotificationReceived: {
      console.debug("Received notification with payload:", JSON.stringify(data))

      // Possible actions:
      // - Read message from data payload and display a user dialog
      // - Navigate to a specific screen
      // - ...
    }
  }
}
