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

  PluginMainItem {
    anchors.bottomMargin: callToAction.height + callToAction.anchors.bottomMargin
  }
  CallToAction { id: callToAction }
}
