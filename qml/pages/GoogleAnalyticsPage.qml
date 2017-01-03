import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "../helper"

ListPage {
  title: "Google Analytics Plugin"

  listView.header: Column {
    width: parent.width

    SectionDescription { text: "Integrate with Google Analytics to measure user interactions for your mobile and desktop apps." }
    SectionContent {
      contentItem: AppImage {
        width: sourceSize.width * dp(1) * 0.75
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/code-ga.png")
      }
    }
    SectionContent {
      contentItem: AppImage {
        anchors.horizontalCenter: parent.horizontalCenter
        width: sourceSize.width * dp(1) * 0.5
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/logo-ga.png")
      }
    }
    SectionHeader { text: "Example" }
  }

  model: ListModel {
    ListElement { section: "Pages"; name: "Send page view" }
    ListElement { section: "Events"; name: "Send event" }
  }

  delegate: SimpleRow {
    text: name

    onSelected: {
      if (index === 0) {
        googleAnalytics.logScreen("GoogleAnalyticsPage")
        NativeDialog.confirm("Google Analytics", "screen logged:\nGoogleAnalyticsPage", function() {}, false)
      }
      else if (index === 1) {
        googleAnalytics.logEvent("Buttons", "Send Event Clicked")
        NativeDialog.confirm("Google Analytics", "event logged:\nButtons\nSend Event Clicked", function(){}, false)
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  GoogleAnalytics {
    id: googleAnalytics

    propertyId: Constants.googleAnalyticsPropertyId
  }
}
