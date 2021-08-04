import QtQuick 2.0
import Felgo 3.0

Rectangle {
  id: cta
  anchors.bottom: parent.bottom
  anchors.bottomMargin: -dp(40)
  width: parent.width
  height: dp(40) + nativeUtils.safeAreaInsets.bottom
  color: Theme.tintColor

  property string linkUrl: "https://felgo.com/plugin-demo/?source=app-plugin-demo&utm_medium=app&utm_source=app-plugin-demo"

  MouseArea {
    anchors.fill: parent
    anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom
    onClicked: {

      // to try: may get rejected in the review by Apple as it links to a product where you can buy something
      if(false && system.isPlatform(System.IOS)) {
        // NOTE: no browser is opened on iOS!
        nativeUtils.displayMessageBox("Get Started with Felgo", "This app is available with full source code on github.\n\nYou can download it for free at\nwww.felgo.com")

        // the custom dialog does not fit the text
//        aboutFelgoDialog.open()

      } else {
        nativeUtils.openUrl(cta.linkUrl)
      }
    }
  }

  Item {
    id: logocontainer
    width: dp(30)
    height: width
    x: dp(5)
    y: dp(60)
    //color: "#0b95c4"

    Item {
      id: logo
      anchors.centerIn: parent
      width: parent.width// - dp(20)
      height: width
      anchors.verticalCenterOffset: height
      Image {
        source: "../../assets/felgo-logo.png"
        anchors.fill: parent
      }
    }
  }

  Item {
    id: getstartedcontainer
    width: parent.width
    height: parent.height
    y: height


    Column {
      id: getstarted
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.horizontalCenterOffset: dp(20)
      //x: dp(20)
      spacing: parent.height
      y: parent.height
      AppText {
        color: "#fff"
        text: "Better Apps, Less Effort"
        font.pixelSize: sp(10)
      }
      Row {
        spacing: dp(10)
        AppText {
          color: "#fff"
          text: "Get Started with Felgo"
          // other variations: "Get Full Source Code", "Download for Free"
          font.pixelSize: sp(14)
        }
        Icon {
          icon: IconType.externallink
          color: "#fff"
          size: sp(13)
          anchors.verticalCenter: parent.verticalCenter
        }
      }
    }
  }

  SequentialAnimation {
    id: showCta
    running: true
    PauseAnimation {
      duration: 2000
    }
    ParallelAnimation {
      NumberAnimation {
        target: cta
        property: "anchors.bottomMargin"
        to: 0
        easing.type: Easing.OutCubic
        duration: 400
      }
      SequentialAnimation {
        PauseAnimation {
          duration: 100
        }
        NumberAnimation {
          target: logocontainer
          property: "y"
          to: dp(5)
          easing.type: Easing.OutBack
          duration: 400
        }
      }
      SequentialAnimation {
        PauseAnimation {
          duration: 200
        }
        NumberAnimation {
          target: logo
          property: "anchors.verticalCenterOffset"
          to: 0
          easing.type: Easing.OutBack
          duration: 400
        }
      }
      SequentialAnimation {
        PauseAnimation {
          duration: 300
        }
        NumberAnimation {
          target: getstartedcontainer
          property: "y"
          to: 0
          easing.type: Easing.OutBack
          duration: 400
        }
      }
      SequentialAnimation {
        PauseAnimation {
          duration: 400
        }
        NumberAnimation {
          target: getstarted
          property: "y"
          to: dp(6)
          easing.type: Easing.OutBack
          duration: 400
        }
      }
      SequentialAnimation {
        PauseAnimation {
          duration: 500
        }
        NumberAnimation {
          target: getstarted
          property: "spacing"
          to: -dp(3)
          easing.type: Easing.OutCubic
          duration: 400
        }
      }
    }
  }


  // the dialog does not fit the content, thus use nativeUtils.displayMessageBox() instead
  Dialog {
    id: aboutFelgoDialog
    title: "Get Started"
    positiveActionLabel: "Ok"
    negativeAction: false // only display the positive button

    AppText {
      anchors.fill: parent
      anchors.margins: dp(8)
      text: "This app is available with full source code in the Felgo SDK.\n\nFree Download at www.felgo.com"
      width: parent.width
    }

    onAccepted: close()
  }

}
