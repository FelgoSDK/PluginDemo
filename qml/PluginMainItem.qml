import Felgo 4.0
import QtQuick 2.0
import "helper"
import "pages"

Item {
  anchors.fill: parent

  // app content with plugin list
  NavigationStack {

    ListPage {
      id: page
      title: qsTr("Felgo Plugins")
      listView.bottomMargin: 0 // safe area is handled in Main.qml

      model: ListModel {
        ListElement { type: "Advertising"; name: "AdMob";
          detailText: "Ad Monetization and Promotion"; image: "../assets/logo-admob.png" }
        ListElement { type: "Advertising"; name: "Chartboost"
          detailText: "Ad Monetization and Promotion"; image: "../assets/logo-chartboost.png" }

        ListElement { type: "In-App Purchases"; name: "Soomla"
          detailText: "In-App Purchases & Virtual Currency"; image: "../assets/logo-soomla.png" }

        ListElement { type: "Social"; name: "GameCenter"
          detailText: "Cross-Platform Gaming Services"; image: "../assets/logo-gamecenter.png" }
        ListElement { type: "Social"; name: "Facebook"
          detailText: "Social Sharing & Friend Invites"; image: "../assets/logo-facebook.png" }

        ListElement { type: "Analytics"; name: "Firebase Analytics"
          detailText: "App Analytics & Events"; image: "../assets/logo-firebase.png" }
        ListElement { type: "Analytics"; name: "Flurry"
          detailText: "User Analytics & App Statistics"; image: "../assets/logo-flurry.png" }
        ListElement { type: "Analytics"; name: "Amplitude"
          detailText: "User Analytics & App Statistics"; image: "../assets/logo-amplitude.png" }

        ListElement { type: "Notifications"; name: "Google Cloud Messaging Push Notifications"
          detailText: "Targeted Push Notifications"; image: "../assets/logo-gcm.png" }
        ListElement { type: "Notifications"; name: "OneSignal Push Notifications"
          detailText: "Targeted Push Notifications"; image: "../assets/logo-onesignal.png" }
        ListElement { type: "Notifications"; name: "Local Notifications"
          detailText: "Schedule Local Notifications"; image: "../assets/logo-localpush.png" }

        ListElement { type: "Beta Testing & Crash Reporting"; name: "HockeyApp"
          detailText: "Beta Distribution & Crash Reports"; image: "../assets/logo-hockey.png" }

        ListElement { type: "Database & Authentication"; name: "Firebase"
          detailText: "Manage users and user Realtime Database"; image: "../assets/logo-firebase.png" }
      }

      delegate: PluginListItem {
        onSelected: {
          switch (index) {
          case 0:
            page.navigationStack.push(Qt.resolvedUrl("pages/AdMobPage.qml"))
            break
          case 1:
            page.navigationStack.push(Qt.resolvedUrl("pages/ChartboostPage.qml"))
            break
          case 2:
            page.navigationStack.push(soomlaPage)
            break
          case 3:
            page.navigationStack.push(Qt.resolvedUrl("pages/GameCenterPage.qml"))
            break
          case 4:
            page.navigationStack.push(facebookPage)
            break
          case 5:
            page.navigationStack.push(Qt.resolvedUrl("pages/firebase/FirebaseAnalyticsPage.qml"))
            break
          case 6:
            page.navigationStack.push(Qt.resolvedUrl("pages/FlurryPage.qml"))
            break
          case 7:
            page.navigationStack.push(Qt.resolvedUrl("pages/AmplitudePage.qml"))
            break
          case 8:
            page.navigationStack.push(Qt.resolvedUrl("pages/GoogleCloudMessagingPage.qml"))
            break
          case 9:
            page.navigationStack.push(Qt.resolvedUrl("pages/OneSignalPage.qml"))
            break
          case 10:
            page.navigationStack.push(notificationPage)
            break
          case 11:
            page.navigationStack.push(Qt.resolvedUrl("pages/HockeyAppPage.qml"))
            break
          case 12:
            page.navigationStack.push(Qt.resolvedUrl("pages/FirebasePage.qml"))
            break
          }
        }
      }

      section.property: "type"
      section.delegate: SimpleSection { }
    }
  }
}
