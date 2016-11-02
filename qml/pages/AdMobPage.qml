import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "../helper"

ListPage {
  title: "AdMob Plugin"

  model: ListModel {
    id: listModel

    ListElement { section: "Visibility"; current: false; name: "Display banner" }
    ListElement { section: "Visibility"; current: false; name: "Hide banner" }

    ListElement { section: "Banner Type"; current: false; name: "Standard (320 x 50)" }
    ListElement { section: "Banner Type"; current: false; name: "Medium Rectangle (300x250)" }
    ListElement { section: "Banner Type"; current: false; name: "Large (320x100)" }
    ListElement { section: "Banner Type"; current: false; name: "Leaderboard (728x90) - Tablet Only" }
    ListElement { section: "Banner Type"; current: true; name: "Smart (auto-size)" }

    ListElement { section: "Interstitial"; active: false; name: "Load and show" }
  }

  delegate: SimpleRow {
    id: row

    text: name
    property bool isSelected: current || (index === 0 && adMobBanner.visible || index === 1 && !adMobBanner.visible)

    Icon {
      anchors.right: parent.right
      anchors.rightMargin: dp(10)
      anchors.verticalCenter: parent.verticalCenter
      icon: IconType.check
      size: dp(14)
      color: row.style.textColor
      visible: isSelected
    }

    style.showDisclosure: false

    onSelected: {

      // Set selection
      if (index >= 2 && index <= 6) {
        for(var i = 0; i < listModel.count; i++) {
          listModel.setProperty(i, "current", i === index ? true : false)
        }
      }

      // Visibility
      if (index === 0) {
        adMobBanner.visible = true
      }
      else if (index === 1) {
        adMobBanner.visible = false
      }
      // Banner types
      else if (index === 2) {
        adMobBanner.banner = AdMobBanner.Standard
      }
      else if (index === 3) {
        adMobBanner.banner = AdMobBanner.Medium
      }
      else if (index === 4) {
        adMobBanner.banner = AdMobBanner.Large
      }
      else if (index === 5) {
        adMobBanner.banner = AdMobBanner.LeaderBoard
      }
      else if (index === 6) {
        adMobBanner.banner = AdMobBanner.Smart
      }
      // Interstitial
      else if (index === 7) {
        interstitial.showInterstitialIfLoaded()
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  Component.onCompleted: {
    // Cache interstitial
    interstitial.loadInterstitial()
  }

  AdMobBanner {
    id: adMobBanner
    adUnitId: Constants.admobBannerAdUnitId
    banner: AdMobBanner.Smart

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottom: parent.bottom

    testDeviceIds: Constants.admobTestDeviceIds
  }

  AdMobInterstitial {
    id: interstitial
    adUnitId: Constants.admobInterstitialAdUnitId

    testDeviceIds: Constants.admobTestDeviceIds
  }
}
