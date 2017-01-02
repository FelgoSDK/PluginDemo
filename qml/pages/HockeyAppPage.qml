import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "../helper"

ListPage {
  title: "HockeyApp Plugin"


  listView.header: Column {
    width: parent.width

    SectionDescription { text: "Integrate with HockeyApp for beta distribution & crash reports." }
    SectionContent {
      contentItem: AppImage {
        width: sourceSize.width * dp(1) * 0.75
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/code-hockeyapp.png")
      }
    }
    SectionHeader { text: "Example" }
  }

  model: ListModel {
    ListElement { section: "Crashes"; name: "Crash app" }
    ListElement { section: "Updates"; name: "Check updates" }
  }

  delegate: SimpleRow {
    text: name

    onSelected: {
      if (index === 0) {
        NativeDialog.confirm("Crash app", "Do you really want to crash the app?", function(confirmed) {
          if(confirmed)
            hockeyApp.forceCrash()
        })
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
