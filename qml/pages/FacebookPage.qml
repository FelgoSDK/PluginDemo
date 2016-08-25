import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.5
import "../helper"

Page {

  title: "Facebook Plugin"

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
    }

    AppText {
      text: facebook.loggedIn ? "Logged in as:\n" + facebook.profile.firstName : "Please log in"
    }
  }

  // login/logout button
  AppButton {
    id: loginButton
    text: facebook.loggedIn ? "Logout" : "Login"
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
    visible: facebook.loggedIn
    anchors.top: loginButton.bottom
    anchors.bottom: parent.bottom
    width: parent.width

    // post a message to facebook
    AppText {
      id: postHeader
      text: "Post a Message: "
      font.bold: true
      x: userProfile.anchors.margins
      height: implicitHeight + userProfile.spacing
    }

    // rectangle with text area
    Rectangle {
      width: parent.width - 2 * userProfile.spacing
      height: messageField.height + dp(8)
      color: "white"
      border.color: Theme.tintColor
      border.width: 1
      anchors.horizontalCenter: parent.horizontalCenter

      AppTextEdit {
        id: messageField
        placeholderText: "What are you up to?"
        text: "I just posted this message with the V-Play Facebook Plugin.\nhttp://www.v-play.net/plugins"
        width: parent.width - dp(16)
        height: messageField.lineCount * messageField.lineHeight
        wrapMode: TextEdit.WordWrap
        font.pixelSize: sp(13)
        horizontalAlignment: TextEdit.AlignLeft
        verticalAlignment: TextEdit.AlignTop
        anchors.centerIn: parent

        property real lineHeight: 0
        Component.onCompleted: lineHeight = messageField.contentHeight / messageField.lineCount
      }
    }

    // post message button
    AppButton {
      text: "Post the message above to Facebook"
      onClicked: facebook.postGraphRequest("me/feed", { message: messageField.text })
      anchors.horizontalCenter: parent.horizontalCenter
    }

    // show facebook friends
    AppText {
      id: friendsHeader
      text: "Friends: "
      font.bold: true
      x: userProfile.anchors.margins
    }

    // list view with friends
    AppListView {
      id: friendsList
      width: parent.width
      height: parent.height - friendsHeader.height
      model: []
      delegate: SimpleRow {
        text: modelData.name
        imageSource: modelData.picture.data.url
        style.showDisclosure: false
      }
      emptyText.text: "No friends use this app."
    }
  }

  Facebook {
    id: facebook

    readonly property bool loggedIn: sessionState === Facebook.SessionOpened

    appId: Constants.facebookAppId
    readPermissions: [ "public_profile", "user_friends" ]
    publishPermissions: ["publish_actions"]

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

    // handle completed post-message graph request
    onPostGraphRequestFinished: {
      if(resultState !== Facebook.ResultOk)
        NativeDialog.confirm("Post Request Failed", "", function(){}, false)
      else
        NativeDialog.confirm("Message Successfully Posted", "", function(){}, false)
    }
  }
}
