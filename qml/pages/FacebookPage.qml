import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.5
import "../helper"

Page {

  title: "Facebook Plugin"

  Grid {
    anchors.fill: parent
    anchors.margins: dp(20)

    columns: 2
    spacing: dp(20)

    RoundedImage {
      width: dp(100)
      height: dp(100)

      source: facebook.profile.pictureUrl
    }

    AppText {
      text: facebook.loggedIn ? "Logged in as:\n" + facebook.profile.firstName : "Please log in"
    }

    AppButton {
      text: facebook.loggedIn ? "Logout" : "Login"

      onClicked: {
        if (facebook.loggedIn) {
          facebook.closeSession()
        }
        else {
          facebook.openSession()
        }
      }
    }
  }

  Facebook {
    id: facebook

    readonly property bool loggedIn: sessionState === Facebook.SessionOpened

    appId: Constants.facebookAppId
    readPermissions: [ "public_profile" ]

    onSessionStateChanged: {
      if (sessionState === Facebook.SessionOpened) {
        fetchUserDetails()
      }
    }
  }
}
