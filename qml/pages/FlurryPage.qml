import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "../helper"

ListPage {

  title: "Flurry Plugin"

  listView.header: Column {
    width: parent.width

    SectionDescription { text: "Integrate with Flurry to get insights into your app's usage." }
    SectionContent {
      contentItem: AppImage {
        width: sourceSize.width * dp(1) * 0.75
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/code-flurry.png")
      }
    }
//    SectionHeader { text: "Example" }
  }

//  model: ListModel {
//    ListElement { section: "Events"; name: "Send event" }
//  }

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
