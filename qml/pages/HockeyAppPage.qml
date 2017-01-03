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

    SectionHeader { text: "Beta Distribution" }
    SectionDescription { text: "When developing an app or game you often want to allow beta testers to install your apps to get feedback early in your development process. With HockeyApp you can upload new versions of your iOS & Android builds and automatically notify your testers about the new version when they open your app the next time." }
    SectionHeader { text: "Crash Reports" }
    SectionDescription { text: "HockeyApp collects and uploads crash reports from you apps or games for you. The plugin currently supports crash reporting for native iOS crashes and Android SDK crashes." }
    SectionContent {
      contentItem: AppImage {
        anchors.horizontalCenter: parent.horizontalCenter
        width: sourceSize.width * dp(1) * 0.5
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/logo-hockey.png")
      }
    }

//    SectionHeader { text: "Example" }
  }

//  model: ListModel {
//    ListElement { section: "Crashes"; name: "Crash app" }
//    ListElement { section: "Updates"; name: "Check updates" }
//  }

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
