import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0

App {
  // You get free licenseKeys from http://v-play.net/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from http://v-play.net/licenseKey>"

  NavigationStack {

    ListPage {
      id: page
      title: qsTr("V-Play Plugins")

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
    }
  }
}
