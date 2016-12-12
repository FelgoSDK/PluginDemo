pragma Singleton

import QtQuick 2.0

Item {
  // will be set to true by launcher to use different keys
  property bool isLauncherApp: false

  readonly property string admobBannerAdUnitId: "ca-app-pub-9155324456588158/9913032020"
  readonly property string admobInterstitialAdUnitId: "ca-app-pub-9155324456588158/9075427220"
  readonly property var admobTestDeviceIds: [ "d17ba18ff075e7c20c5ce081813d9666", "28CA0A7F16015163A1C70EA42709318A" ]

  readonly property string chartboostIosAppId: isLauncherApp ? "584e9c42f6cd452b346c29c3" : "53609edd89b0bb726b46c6e0"
  readonly property string chartboostAndroidAppId: isLauncherApp ? "584e9c1743150f42467d92be" : "53609f3789b0bb72b4b95836"
  readonly property string chartboostIosAppSignature: isLauncherApp ? "f6256c5c1bf8c53f2d71a5502e704c501d80a3e8" : "6fed94ffeaf6abb3d5aa85781e59fa2fb83354b8"
  readonly property string chartboostAndroidAppSignature: isLauncherApp ? "65bc91b0bc4c7b1f99a1069583318b5c91d4bdce" : "c87b4e51a85b76a4bbe41ee880634fc9ae875ca8"

  readonly property string facebookAppId: "1014223965320966"

  readonly property string flurryApiKey: "HMV9VC35FS77G6QK9TNZ"

  readonly property string googleAnalyticsPropertyId: "UA-32264673-5"

  readonly property string hockeyAppiOSAppid: "8bb55b2d177645449bec6e6794f6fc0b"
  readonly property string hockeyAppAndroidAppid: "04678da6f0b34c98abe7ade378e1e4ae"

  readonly property string oneSignalAppId: "a23e646c-0d6f-4611-836e-5bf14ee96e98"
  readonly property string oneSignalGoogleProjectNumber: "522591647137"

  readonly property string soomlaSecret: "<your-game-secret>"
  readonly property string soomlaAndroidPublicKey: "<android-public-key>"

}
