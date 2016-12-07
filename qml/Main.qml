import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "helper"

App {
  PluginMainItem {
    anchors.bottomMargin: callToAction.height + callToAction.anchors.bottomMargin
  }
  CallToAction { id: callToAction }
}
