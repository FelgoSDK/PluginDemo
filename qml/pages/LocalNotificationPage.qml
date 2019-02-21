import Felgo 3.0
import QtQuick 2.0
import "../helper"

ListPage {
  title: "Local Notifications Plugin"

  listView.header: Column {
    width: parent.width

    SectionDescription { text: "Schedule native local push notifications in your app." }
    SectionContent {
      contentItem: AppImage {
        width: sourceSize.width * dp(1) * 0.75
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/code-localpush.png")
      }
    }
    SectionContent {
      contentItem: AppImage {
        anchors.horizontalCenter: parent.horizontalCenter
        width: sourceSize.width * dp(1) * 0.5
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/logo-localpush.png")
      }
    }

    SectionHeader { text: "Example" }
  }

  model: ListModel {
    ListElement { section: "Notifications"; name: "Schedule notification" }
    ListElement { section: "Notifications"; name: "Cancel all notifications" }
  }

  delegate: SimpleRow {
    text: name

    onSelected: {
      if (index === 0) {
        NativeDialog.confirm("Local Notifications", "A test notification will be scheduled to arrive in 3 seconds.", function(confirmed) {
          if(confirmed)
            notificationmanager.schedule({ message: "Notification Test", number: 1, timeInterval: 3 })
        })
      }
      else if (index === 1) {
        notificationmanager.cancelAllNotifications()
        NativeDialog.confirm("Local Notifications", "All notifications cancelled.", null, false)
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  NotificationManager {
    id: notificationmanager
    onNotificationFired: NativeDialog.confirm("Local Notifications", "Notification with id " + notificationId + " fired", null, false)
  }
}
