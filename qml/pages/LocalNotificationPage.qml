import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "../helper"

ListPage {
  title: "Local Notifications Plugin"

  model: ListModel {
    ListElement { section: "Notifications"; name: "Schedule notification" }
    ListElement { section: "Notifications"; name: "Cancel all notifications" }
  }

  delegate: SimpleRow {
    text: name

    onSelected: {
      if (index === 0) {
        notificationmanager.schedule({ message: "Notification Test", number: 1, timeInterval: 8 })
      }
      else if (index === 1) {
        notificationmanager.cancelAllNotifications()
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  NotificationManager {
    id: notificationmanager
  }
}
