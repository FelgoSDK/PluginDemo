import VPlayApps 1.0
import QtQuick 2.5
import QtGraphicalEffects 1.0

Rectangle {
  id: listItem
  width: parent && parent.width || 0
  height: itemContent.height
  color: Theme.listItem.backgroundColor

  signal selected(var item)

  // separator
  Rectangle {
    anchors.bottom: parent.bottom
    width: parent.width
    height: dp(1)
    z: 1
    color: Theme.listItem.dividerColor
  }

  // content row
  Row {
    id: itemContent
    width: parent.width - x
    height: Math.max(appImg.height, descriptionText.height) + dp(Theme.navigationBar.defaultBarItemPadding)
    clip: true
    spacing: dp(Theme.navigationBar.defaultBarItemPadding)
    x: spacing

    // img
    AppImage {
      id: appImg
      height: width / sourceSize.width * sourceSize.height
      width: dp(50)
      source: image ? Qt.resolvedUrl("../"+image) : ""
      anchors.verticalCenter: parent.verticalCenter
    }

    // description
    Column {
      id: descriptionText
      width: parent.width - appImg.width - parent.spacing
      spacing: dp(Theme.navigationBar.defaultBarItemPadding) * 0.5
      anchors.verticalCenter: parent.verticalCenter

      property real textWidth: width - spacing * 2 - (discosureText.visible ? discosureText.width + dp(Theme.navigationBar.defaultBarItemPadding) : 0)

      Item { height: dp(Theme.navigationBar.defaultBarItemPadding) - parent.spacing; width: parent.width } // spacer
      AppText {
        id: headerTxt
        x: parent.spacing
        text: name
        width: parent.textWidth
        wrapMode: AppText.WordWrap
        font.pixelSize: dp(12)
      }
      AppText {
        x: parent.spacing
        width: parent.textWidth
        wrapMode: AppText.WrapAtWordBoundaryOrAnywhere
        font.pixelSize: sp(10)
        color: Theme.secondaryTextColor
        text: detailText || ""
      }
      Item { height: dp(Theme.navigationBar.defaultBarItemPadding) - parent.spacing; width: parent.width } // spacer
    }
  }

  // disclosure
  Text {
    id: discosureText
    color: Theme.listItem.disclosureColor
    font.family: Theme.iconFont.name
    font.pixelSize: dp(22)
    wrapMode: Text.WordWrap
    text: IconType.angleright
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    anchors.rightMargin: dp(Theme.navigationBar.defaultBarItemPadding)
    visible: Theme.isIos
  }

  // pressed effect (non-android)
  Rectangle {
    anchors.fill: parent
    visible: !Theme.isAndroid && mouseArea.pressed
    color: Theme.listItem.selectedBackgroundColor
    opacity: 0.35
  }

  // ripple mouse area
  RippleMouseArea {
    id: mouseArea
    anchors.fill: parent
    circularBackground: false
    onClicked: listItem.selected(index)
  }
}
