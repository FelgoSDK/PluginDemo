import VPlayApps 1.0
import QtQuick 2.0
import QtQuick.Layouts 1.1
import VPlayPlugins 1.0

Page {
  id: loginPage
  title: "Login"

  property bool authenticated: firebaseAuth.authenticated
  signal registrationRequired

  function logoutUser() {
    firebaseAuth.logoutUser()
  }

  // A dialog to give feedback on login and registration attempts
  Dialog {
    id: loginDialog
    title: ""
    positiveActionLabel: "OK"
    z: 1 // make sure the dialog is on top
    negativeAction: false

    property alias text: dialogText.text

    onAccepted: {
      close()
      loginPage.opacity = 0
    }

    AppText {
      id: dialogText
      anchors.fill: parent
    }
  }

  // Use the FirebaseAuth Item to register and log in/log out users
  FirebaseAuth {
    id: firebaseAuth

    onUserRegistered: {

      indicator.stopAnimating()

      console.debug("User login " + success + " - " + message)

      if(success) {
        loginDialog.title = "Success!"
      } else {
        loginDialog.title = "An Issue occured!"
      }

      // Update UI
      loginDialog.text = message
      loginbutton.visible = true
      registerCheckbox.visible = true
      loginDialog.open()
    }

    onLoggedIn:  {
      indicator.stopAnimating()

      console.debug("User login " + success + " - " + message)

      if(success) {
        loginDialog.title = "Success!"
      } else {
        loginDialog.title = "An Issue occured!"
      }

      // Update UI
      loginDialog.text = message
      loginbutton.visible = true
      registerCheckbox.visible = true
      loginDialog.open()
    }
  }

  backgroundColor: Qt.rgba(0,0,0, 0.75) // page background is translucent, we can see other items beneath the page

  // login form background
  Rectangle {
    id: loginForm
    anchors.centerIn: parent
    color: "white"
    width: content.width + dp(48)
    height: content.height + dp(16)
    radius: dp(4)
  }

  // login form content
  GridLayout {
    id: content
    anchors.centerIn: loginForm
    columnSpacing: dp(20)
    rowSpacing: dp(10)
    columns: 2

    AppCheckBox {
      id: registerCheckbox
      Layout.topMargin: dp(8)
      Layout.bottomMargin: dp(12)
      Layout.columnSpan: 2
      Layout.alignment: Qt.AlignHCenter
      text: qsTr("Register New User")
      visible: false
    }

    // headline
    AppText {
      id: loginLabel
      Layout.topMargin: dp(8)
      Layout.bottomMargin: dp(12)
      Layout.columnSpan: 2
      Layout.alignment: Qt.AlignHCenter
      text: registerCheckbox.checked ? "Register" : "Login"
    }

    // email text and field
    AppText {
      text: qsTr("E-mail")
      font.pixelSize: sp(12)
    }

    AppTextField {
      id: txtUsername
      Layout.preferredWidth: dp(200)
      showClearButton: true
      font.pixelSize: sp(14)
      borderColor: Theme.tintColor
      borderWidth: !Theme.isAndroid ? dp(2) : 0
    }

    // password text and field
    AppText {
      text: qsTr("Password")
      font.pixelSize: sp(12)
    }

    AppTextField {
      id: txtPassword
      Layout.preferredWidth: dp(200)
      showClearButton: true
      font.pixelSize: sp(14)
      borderColor: Theme.tintColor
      borderWidth: !Theme.isAndroid ? dp(2) : 0
      echoMode: TextInput.Password
    }

    // column for buttons, we use column here to avoid additional spacing between buttons
    Column {
      Layout.fillWidth: true
      Layout.columnSpan: 2
      Layout.topMargin: dp(12)

      // buttons
      AppButton {
        id: loginbutton
        text: registerCheckbox.checked ? "Register" : "Login"
        flat: false
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: {

          // login with firebase
          loginPage.forceActiveFocus() // move focus away from text fields
          loginbutton.visible = false
          registerCheckbox.visible = false
          indicator.visible = true;
          indicator.startAnimating()

          ////////////////////////
          // login and register with firebase
          ////////////////////////
          if(registerCheckbox.checked) {
            // Register firebase user
            firebaseAuth.registerUser(txtUsername.text, txtPassword.text)
          } else {
            firebaseAuth.loginUser(txtUsername.text, txtPassword.text)
          }
        }
      }

      AppActivityIndicator {
        id: indicator
        z: 1
        animating: false
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        hidesWhenStopped: true
        color: Theme.tintColor
      }
    }
  }
}
