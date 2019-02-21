pragma Singleton

import QtQuick 2.0

Item {

  //test ad units by admob: https://developers.google.com/admob/android/test-ads
  readonly property string admobBannerAdUnitId: "ca-app-pub-3940256099942544/6300978111"
  readonly property string admobNativeAdUnitId: "ca-app-pub-3940256099942544/2793859312"
  readonly property string admobInterstitialAdUnitId: "ca-app-pub-3940256099942544/1033173712"
  readonly property string admobRewardedVideoAdUnitId: "ca-app-pub-3940256099942544/5224354917"
  readonly property var admobTestDeviceIds: [ "d17ba18ff075e7c20c5ce081813d9666", "28CA0A7F16015163A1C70EA42709318A" ]
  readonly property string chartboostIosAppId: "53609edd89b0bb726b46c6e0"
  readonly property string chartboostAndroidAppId: "53609f3789b0bb72b4b95836"
  readonly property string chartboostIosAppSignature: "6fed94ffeaf6abb3d5aa85781e59fa2fb83354b8"
  readonly property string chartboostAndroidAppSignature: "c87b4e51a85b76a4bbe41ee880634fc9ae875ca8"

  //IDs created by Felgo for PluginDemo app, use your own IDs to see analytics

  readonly property string amplitudeApiKey: "47f92e5a607264e66bffa4aa3c94ce2a"

  readonly property string flurryApiKey: "HMV9VC35FS77G6QK9TNZ"

  readonly property string googleAnalyticsPropertyId: "UA-32264673-5"

  readonly property string hockeyAppiOSAppid: "8bb55b2d177645449bec6e6794f6fc0b"
  readonly property string hockeyAppAndroidAppid: "04678da6f0b34c98abe7ade378e1e4ae"

  readonly property string oneSignalAppId: "a23e646c-0d6f-4611-836e-5bf14ee96e98"
  readonly property string oneSignalGoogleProjectNumber: "522591647137"

  // soomla
  property string soomlaSecret: "<your-game-secret>"
  property string soomlaAndroidPublicKey: "<android-public-key>"
  property string creditsCurrencyItemId: "net.vplay.demos.PluginDemo.credits"
  property string creditsPackItemId: "net.vplay.demos.PluginDemo.creditspack"
  property string goodieItemId: "net.vplay.demos.PluginDemo.goodie"
  property string noAdsItemId: "net.vplay.demos.PluginDemo.noads"

  // gamecenter
  property string gcLeaderboardID: "leaderboard_main"
  property string gcAchievementID: "achievement_1"

  // fb
  property string facebookAppId: "1014223965320966"
}
