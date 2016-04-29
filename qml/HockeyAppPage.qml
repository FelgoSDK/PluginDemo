import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0

ListPage {
  title: "HockeyApp Plugin"

  model: ListModel {
    ListElement { section: "Crashes"; name: "Crash app" }
    ListElement { section: "Updates"; name: "Check updates" }
  }

  delegate: SimpleRow {
    text: name

    onSelected: {
      if (index === 0) {
        hockeyApp.forceCrash()
      }
      else if (index === 1) {
        hockeyApp.showUpdateView()
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  HockeyApp {
    id: hockeyApp
    appId: Theme.isIos ? Constants.hockeyAppiOSAppid : Constants.hockeyAppAndroidAppid
  }
}
