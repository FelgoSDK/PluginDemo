import Felgo 4.0
import QtQuick 2.0
import "../helper"

ListPage {
  title: "Chartboost Plugin"

  listView.header: Column {
    width: parent.width

    SectionDescription { text: "Integrate with Chartboost to monetize and cross-promote your games with ads." }
    SectionContent {
      contentItem: AppImage {
        width: sourceSize.width * dp(1) * 0.75
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/code-chartboost.png")
      }
    }
    SectionContent {
      contentItem: AppImage {
        anchors.horizontalCenter: parent.horizontalCenter
        width: sourceSize.width * dp(1) * 0.5
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/logo-chartboost.png")
      }
    }

    SectionHeader { text: "Example" }
  }

  model: ListModel {
    ListElement { section: "Interstitial"; name: "Load and show" }
    ListElement { section: "Interstitial"; name: "Cache interstitial" }
    ListElement { section: "Interstitial"; name: "Show Interstitial" }
    ListElement { section: "Rewarded Video"; name: "Cache Video" }
    ListElement { section: "Rewarded Video"; name: "Show Video" }
   // ListElement { section: "More"; name: "Load and show" }

  }

  delegate: SimpleRow {
    text: name

    onSelected: index => {
      // Interstitial
      if (index === 0) {
        chartboost.showInterstitial()
      } else if (index === 1) {
        chartboost.cacheInterstitial(Chartboost.HomeScreenLocation)
      } else if(index === 2) {
        chartboost.showInterstitial(Chartboost.HomeScreenLocation)
      } else if(index === 3) {
        chartboost.cacheRewardedVideo(Chartboost.DefaultLocation)
      } else if (index === 4) {
        chartboost.showRewardedVideo(Chartboost.DefaultLocation)
      } else if (index === 5) {
        chartboost.showMoreApps(Chartboost.DefaultLocation)
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  Chartboost {
    id: chartboost
    property bool rewardReady: false

    appId: Theme.isIos ? Constants.chartboostIosAppId : Constants.chartboostAndroidAppId
    appSignature: Theme.isIos ? Constants.chartboostIosAppSignature : Constants.chartboostAndroidAppSignature

    onRewardedVideoCached: (location, locationType) => {
      rewardReady = true
      console.debug("Rewarded Video was cached!")
      NativeDialog.confirm("Rewarded Video Cached", "Rewarded Video is now cached.", function() {}, false)
    }

    onInterstitialCached: (location, locationType) => {
      console.log("Interstitial Cached for " + location + " or locationType: " + locationType)
      if(locationType === Chartboost.HomeScreenLocation) {
        console.log("Interstitial cached for HomeScreen")
      }
      NativeDialog.confirm("Interstitial Cached", "Interstitial is now cached.", function() {}, false)
    }

    // handle failed to load
    onRewardedVideoFailedToLoad: NativeDialog.confirm("Rewarded Video Failed", "Rewarded Video failed to load.", function() {}, false)
    onInterstitialFailedToLoad: NativeDialog.confirm("Interstitial Failed", "Interstitial failed to load.", function() {}, false)

    shouldRequestInterstitialsInFirstSession: true
  }
}
