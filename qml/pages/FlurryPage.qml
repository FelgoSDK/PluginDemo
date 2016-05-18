import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "../helper"

ListPage {

  title: "Flurry Plugin"

  model: ListModel {
    ListElement { section: "Events"; name: "Send event" }
  }

  delegate: SimpleRow {
    text: name

    onSelected: {
      if (index === 0) {
        flurry.logEvent("Buttons", "Send Event Clicked")
        NativeDialog.confirm("Flurry", "event logged:\nButtons\nSend Event Clicked", function(){}, false)
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  Flurry {
    id: flurry

    apiKey: Constants.flurryApiKey
  }

}
