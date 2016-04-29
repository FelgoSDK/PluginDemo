import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0

ListPage {
  title: "Chartboost Plugin"

  model: ListModel {
    ListElement { section: "Interstitial"; name: "Load and show" }
  }

  delegate: SimpleRow {
    text: name

    onSelected: {
      // Interstitial
      if (index === 0) {
        chartboost.showInterstitial()
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  Chartboost {
    id: chartboost

    appId: Theme.isIos ? Constants.chartboostIosAppId : Constants.chartboostAndroidAppId
    appSignature: Theme.isIos ? Constants.chartboostIosAppSignature : Constants.chartboostAndroidAppSignature

    shouldRequestInterstitialsInFirstSession: true
  }
}
