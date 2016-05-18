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
        NativeDialog.confirm("Local Notifications", "A test notification will be scheduled to arrive in 8 seconds.", function(confirmed) {
          if(confirmed)
            notificationmanager.schedule({ message: "Notification Test", number: 1, timeInterval: 8 })
        })
      }
      else if (index === 1) {
        notificationmanager.cancelAllNotifications()
        NativeDialog.confirm("Local Notifications", "All notifications cancelled.", function(){}, false)
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  NotificationManager {
    id: notificationmanager
    onNotificationFired: NativeDialog.confirm("Local Notifications", "Notification with id "+notificationId+" fired", function(){}, false)
  }
}
