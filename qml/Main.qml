import Felgo 3.0
import QtQuick 2.0
import "helper"
import "pages"

App {
  // You get free licenseKeys from https://felgo.com/licenseKey
  // With a licenseKey you can:
  //  * Publish your games & apps for the app stores
  //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
  //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
  //licenseKey: "<generate one from https://felgo.com/licenseKey>"

  PluginMainItem {
    id: pluginMainItem

    // keep only one soomla, facebook and notification page alive within app (to prevent crashes)
    property alias soomlaPage: soomlaPage
    property alias facebookPage: facebookPage
    property alias notificationPage: notificationPage

    SoomlaPage {
      id: soomlaPage
      visible: false
      onPushed: soomlaPage.listView.contentY = soomlaPage.listView.originY
      onPopped: { soomlaPage.parent = pluginMainItem; visible = false }
    }

    FacebookPage {
      id: facebookPage
      visible: false
      onPopped: { facebookPage.parent = pluginMainItem; visible = false }
    }

    LocalNotificationPage {
      id: notificationPage
      visible: false
      onPopped: { notificationPage.parent = pluginMainItem; visible = false }
    }

    anchors.bottomMargin: callToAction.height
  }
  CallToAction { id: callToAction }
}
