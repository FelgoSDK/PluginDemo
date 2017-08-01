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
        output.text = output.text + "\nSuccessfully wrote to DB\n"
      } else {
        console.debug("Write failed with error: " + message)
        output.text = "Write failed with error: " + message
      }
    }

    onRealtimeUserValueChanged: {
      output.text = value
    }
  }

  AppText {
    id: output
    text: "Values will be displayed here"
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
  }

  Flickable {
    anchors.top: output.bottom
    anchors.bottom: parent.bottom
    contentHeight: column.height

    Column {
      id: column
      spacing: dp(20)

      AppTextField {
        id: email

        visible: !firebaseAuth.authenticated
        text: "test12@test.com"
        showClearButton: true
      }

      AppTextField {
        id: pw

        visible: !firebaseAuth.authenticated
        text: "test12"
        showClearButton: true
        echoMode: TextInput.PasswordEchoOnEdit
      }

      AppButton {
        text: "Log in"
        visible: !firebaseAuth.authenticated
        flat: false
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
        flat: false

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
        flat: false

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
        text: "Save User Value"
        flat: false

        onClicked: firebaseDb.setUserValue("teststring", "Last Update: " + new Date().toLocaleString())
      }

      AppButton {
        visible: firebaseAuth.authenticated
        text: "Get User Value"
        flat: false

        onClicked: firebaseDb.getUserValue("teststring")
      }

      AppButton {
        visible: firebaseAuth.authenticated
        text: "Add User Value Listener"
        flat: false

        // you can add realtime values by directly adding them to the realtimeUserValueKeys list
        onClicked: firebaseDb.realtimeUserValueKeys.push("teststring")
      }

      AppButton {
        visible: firebaseAuth.authenticated
        text: "Add User Value Listener (other Method)"
        flat: false

        // Or you can add realtime values by adding them using the
        onClicked: firebaseDb.addRealtimeUserValueKey("teststring")
      }

      AppButton {
        visible: firebaseAuth.authenticated
        text: "Remove User Value Listener"
        flat: false

        onClicked: {
          // you can remove realtime values by directly editing the realtimeUserValueKeys list
          // find index of array
          var index = firebaseDb.realtimeUserValueKeys.indexOf("teststring")

          // splice array to remove the key
          firebaseDb.realtimeUserValueKeys.splice(index, 1)
        }
      }

      AppButton {
        visible: firebaseAuth.authenticated
        text: "Remove User Value Listener (other Method)"
        flat: false

        onClicked: {
          // You can also remove realtime values using the removeRealtimeUserValueKey() method
          firebaseDb.removeRealtimeUserValueKey("teststring")
        }
      }

      AppButton {
        visible: firebaseAuth.authenticated
        text: "Log out"
        flat: false

        onClicked: firebaseAuth.logoutUser()
      }
    }//Column
  }//Flickable
}// Page
