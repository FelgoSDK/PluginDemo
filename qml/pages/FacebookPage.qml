import Felgo 3.0
import QtQuick 2.5
import "../helper"

Page {

  title: "Facebook Plugin"

  ScrollIndicator {
    flickable: flick
    z: 1
  }

  AppFlickable {
    id: flick
    anchors.fill: parent
    contentHeight: pluginInfo.height + example.height

    Column {
      id: pluginInfo
      width: parent.width
      SectionDescription { text: "Integrate with Facebook to help you build engaging social apps and get more installs." }
      SectionContent {
        contentItem: AppImage {
          width: sourceSize.width * dp(1) * 0.75
          height: width / sourceSize.width * sourceSize.height
          source: Qt.resolvedUrl("../../assets/code-facebook.png")
        }
      }
      SectionContent {
        contentItem: AppImage {
          anchors.horizontalCenter: parent.horizontalCenter
          width: sourceSize.width * dp(1) * 0.5
          height: width / sourceSize.width * sourceSize.height
          source: Qt.resolvedUrl("../../assets/logo-facebook.png")
        }
      }

      SectionHeader { text: "Example" }
    }

    Item {
      id: example
      width: parent.width
      height: userProfile.height + loginButton.height + (facebook.loggedIn ? facebookActions.height : 0) + dp(30)
      anchors.top: pluginInfo.bottom

      // user image and name
      Row {
        id: userProfile
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: dp(20)
        spacing: dp(20)

        RoundedImage {
          width: dp(100)
          height: dp(100)
          source: facebook.profile.pictureUrl
          visible: facebook.loggedIn
        }

        AppText {
          text: facebook.loggedIn ? "Logged in as:\n" + facebook.profile.firstName : "Please log in"
        }
      }

      // login/logout button
      AppButton {
        id: loginButton
        text: facebook.loggedIn ? "Logout" : "Login"
        flat: false
        anchors.top: userProfile.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {
          if (facebook.loggedIn) {
            facebook.closeSession()
          }
          else {
            facebook.openSession()
          }
        }
      }

      // only if logged in: allow post to wall and show friends
      Column {
        id: facebookActions
        visible: facebook.loggedIn
        anchors.top: loginButton.bottom
        width: parent.width

        // show facebook friends
        AppText {
          id: friendsHeader
          width: parent.width - 2 * x
          text: "Friends (who also used Facebook login with this app): "
          font.bold: true
          wrapMode: AppText.WordWrap
          height: implicitHeight + userProfile.anchors.margins
          x: userProfile.anchors.margins
        }

        // list view with friends
        Repeater {
          id: friendsList
          width: parent.width
          model: []
          delegate: SimpleRow {
            text: modelData.name
            imageSource: modelData.picture.data.url
            style.showDisclosure: false
          }
        }
      } // Column
    } // Example
  } // Flickable

  Facebook {
    id: facebook

    readonly property bool loggedIn: sessionState === Facebook.SessionOpened

    appId: Constants.facebookAppId
    readPermissions: [ "public_profile", "email", "user_friends" ]

    // fetch data after log in
    onSessionStateChanged: {
      if (sessionState === Facebook.SessionOpened) {
        fetchUserDetails() // get user details
        facebook.getGraphRequest("me/friends", { fields: "id,name,picture" }) // get friends that use the app
      }
    }

    // handle completed get-friends graph request
    onGetGraphRequestFinished: {
      if(resultState !== Facebook.ResultOk)
        NativeDialog.confirm("Retrieving Friends Failed", "", function(){}, false)

      // show friends
      if(graphPath === "me/friends") {
        friendsList.model = JSON.parse(result).data
      }
    }
  }
}
