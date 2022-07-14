import Felgo 3.0
import QtQuick 2.0

Page {
  // make the background red if the user is logged out,
  // and green if logged in
  backgroundColor: firebaseAuth.authenticated ? "green" : "red"

  FirebaseAuth {
    id: firebaseAuth

    onAuthenticatedChanged: {
      console.log("Authenticated changed " + authenticated)
    }

    onUserRegistered: {
      console.debug("User registered: " + success + " - " + message)
    }

    onLoggedIn:  {
      console.debug("User login: " + success + " - " + message)
    }

    onUserDeleted: {
      console.debug("User deleted: "+ success + " - " + message)
    }

  }

  Column {
    anchors.fill: parent

    AppButton {
      text: "Register User"
      onClicked: firebaseAuth.registerUser("test@test.com", "thebestpassword")
    }

    AppButton {
      text: "Log in"
      onClicked: firebaseAuth.loginUser("test@test.com", "thebestpassword")
    }

    AppButton {
      text: "Log out"
      onClicked: firebaseAuth.logoutUser()
    }

    AppButton {
      text: "Delete user"
      onClicked: firebaseAuth.deleteUser()
    }

    AppText {
      // shows the email address if the user is logged in
      text: firebaseAuth.email + " " + firebaseAuth.authenticated
    }
  }
}
