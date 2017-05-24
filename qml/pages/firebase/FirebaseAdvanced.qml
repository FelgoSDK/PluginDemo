import VPlayPlugins 1.0
import VPlayApps 1.0
import QtQuick 2.0

Page {

  FirebaseAuth {
    id: firebaseAuth

    onUserRegistered: {
      console.debug("User registered: " + success + " - " + message)
      output.text = message
    }

    onLoggedIn:  {
      console.debug("User login: " + success + " - " + message)
      output.text = message
    }

    onPasswordResetEmailSent: {
      console.debug("Email Sent: " + success + " - " + message)
      output.text = message
    }
  }

  FirebaseDatabase {
    id: firebaseDb

    onReadCompleted: {
      if(success) {
        console.debug("Read value " +  value + " for key " + key)
      } else {
        console.debug("Error: "  + value)
      }
      output.text = value
    }

    onWriteCompleted: {
      if(success) {
        console.debug("Successfully wrote to DB")
        output.text = "Successfully wrote to DB"
      } else {
        console.debug("Write failed with error: " + message)
        output.text = "Write failed with error: " + message
      }
    }
  }

  Column {
    spacing: dp(20)

    AppTextField {
      id: email

      visible: !firebaseAuth.authenticated
      text: "E-Mail"
      showClearButton: true
    }

    AppTextField {
      id: pw

      visible: !firebaseAuth.authenticated
      text: "Password"
      showClearButton: true
      echoMode: TextInput.PasswordEchoOnEdit
    }

    AppButton {
      text: "Log in"
      visible: !firebaseAuth.authenticated
      onClicked: {
        if(email.text.length > 0 && pw.text.length > 0) {
          firebaseAuth.loginUser(email.text, pw.text)
        } else {
          output.text = "Please enter an e-mail adress and a password!"
        }
      }
    }

    AppButton {
      text: "Register"
      visible: !firebaseAuth.authenticated
      onClicked:
      {
        if(email.text.length > 0 && pw.text.length > 0) {
          firebaseAuth.registerUser(email.text, pw.text)
        } else {
          output.text = "Please enter an e-mail adress and a password!"
        }
      }
    }

    AppButton {
      text: "Send Password Link"
      visible: !firebaseAuth.authenticated
      onClicked: {
        if(email.text.length > 0) {
          firebaseAuth.sendPasswordResetMail(email.text)
        } else {
          output.text = "Please enter an e-mail adress!"
        }
      }
    }

    AppButton {
      visible: firebaseAuth.authenticated
      text: "Save Private Value"
      onClicked: firebaseDb.setValue("teststring", "test")
    }

    AppButton {
      visible: firebaseAuth.authenticated
      text: "Get Private Value"
      onClicked: firebaseDb.getValue("teststring")
    }

    AppButton {
      visible: firebaseAuth.authenticated
      text: "Log out"
      onClicked: firebaseAuth.logoutUser()
    }

    AppText {
      id: output
      text: ""
    }
  }

}// Page
