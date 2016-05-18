import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "../helper"

ListPage {

  title: "Google Analytics Plugin"

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
