import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0

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
      }
      else if (index === 1) {
        googleAnalytics.logEvent("Buttons", "Send Event Clicked")
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
