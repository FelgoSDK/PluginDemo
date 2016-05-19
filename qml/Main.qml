import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "helper"

App {
  // You get free licenseKeys from http://v-play.net/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from http://v-play.net/licenseKey>"

  // define NotificationManager once per app in main window
  NotificationManager {
    id: notificationmanager
    onNotificationFired: NativeDialog.confirm("Local Notifications", "Notification with id "+notificationId+" fired", function(){}, false)
  }

  // define OneSignal once per app in main window
  OneSignal {
    id: onesignal

    logLevel: OneSignal.LogLevelVerbose
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

  // define AdMobBanner once per app in main window
  AdMobBanner {
    id: adMobBanner
    adUnitId: Constants.admobBannerAdUnitId
    banner: AdMobBanner.Smart

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom

    testDeviceIds: Constants.admobTestDeviceIds
    visible: false // will be shown in AdMob page
  }

  // nagation stack
  NavigationStack {
    // automatically show/hide AdMobBanner when navigating
    onCurrentTitleChanged: currentTitle == "AdMob Plugin" ? adMobBanner.visible = true : adMobBanner.visible = false

    ListPage {
      id: page
      title: qsTr("V-Play Plugins")

      listView.anchors.fill: null // do not fill page
      listView.height: listView.parent.height - callToAction.height // leave space for call to action
      listView.width: listView.parent.width

      model: ListModel {
        ListElement { type: "Advertising"; name: "AdMob" }
        ListElement { type: "Advertising"; name: "Chartboost" }

        ListElement { type: "In-App Purchases"; name: "Soomla" }

        ListElement { type: "Social"; name: "GameCenter" }
        ListElement { type: "Social"; name: "Facebook" }

        ListElement { type: "Analytics"; name: "Google Analytics" }
        ListElement { type: "Analytics"; name: "Flurry" }

        ListElement { type: "Notifications"; name: "OneSignal Push Notifications" }
        ListElement { type: "Notifications"; name: "Local Notifications" }

        ListElement { type: "Beta Testing & Crash Reporting"; name: "HockeyApp" }
      }

      delegate: SimpleRow {
        text: name

        onSelected: {
          switch (index) {
          case 0:
            page.navigationStack.push(Qt.resolvedUrl("pages/AdMobPage.qml"))
            break
          case 1:
            page.navigationStack.push(Qt.resolvedUrl("pages/ChartboostPage.qml"))
            break
          case 2:
            page.navigationStack.push(Qt.resolvedUrl("pages/SoomlaPage.qml"))
            break
          case 3:
            page.navigationStack.push(Qt.resolvedUrl("pages/GameCenterPage.qml"))
            break
          case 4:
            page.navigationStack.push(Qt.resolvedUrl("pages/FacebookPage.qml"))
            break
          case 5:
            page.navigationStack.push(Qt.resolvedUrl("pages/GoogleAnalyticsPage.qml"))
            break
          case 6:
            page.navigationStack.push(Qt.resolvedUrl("pages/FlurryPage.qml"))
            break
          case 7:
            page.navigationStack.push(Qt.resolvedUrl("pages/OneSignalPage.qml"))
            break
          case 8:
            page.navigationStack.push(Qt.resolvedUrl("pages/LocalNotificationPage.qml"))
            break
          case 9:
            page.navigationStack.push(Qt.resolvedUrl("pages/HockeyAppPage.qml"))
            break
          }
        }
      }

      section.property: "type"
      section.delegate: SimpleSection { }

      CallToAction { id: callToAction }
    }
  }
}
