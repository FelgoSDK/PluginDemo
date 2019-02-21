import Felgo 3.0
import QtQuick 2.0
import "./firebase"

ListPage {
  id: firebasePage

  title: "Firebase Plugin"

  FirebaseLoginPage {
    id: loginPage
    opacity: 0
    z: 1 // show login above actual app pages
    visible: opacity > 0
    enabled: visible
    Behavior on opacity { NumberAnimation { duration: 250 } } // page fade in/out
  }

  // Use the FirebaseDatabase Item to save and retrieve data
  FirebaseDatabase {
    id: db

    onReadCompleted: {
      if(success) {
        console.debug("Read value " +  value + " for key " + key)

        feedbackDialog.title = "Success!"
        feedbackDialog.text = "Read value " +  value + " for key " + key
      } else {
        console.debug("Error with message: "  + value)

        feedbackDialog.title = "Error!"
        feedbackDialog.text = value
      }
      feedbackDialog.open()
    }

    onWriteCompleted: {
      if(success) {
        console.debug("Successfully wrote to DB")
        feedbackDialog.title = "Success!"
        feedbackDialog.text = message
      } else {
        console.debug("Write failed with error: " + message)
        feedbackDialog.title = "Error!"
        feedbackDialog.text = message
      }
      feedbackDialog.open()
    }
  }

  Dialog {
    id: feedbackDialog
    title: ""
    positiveActionLabel: "OK"
    negativeAction: false

    property alias text: dialogText.text
    onAccepted: close()

    AppText {
      id: dialogText
      anchors.fill: parent
      anchors.leftMargin: 4
      anchors.rightMargin: 4
    }
  }

  model: [{type: "Authentication", text: "Register new User", visible: !loginPage.authenticated},
    { type: "Authentication", text: "Firebase Log In", visible: !loginPage.authenticated },
    { type: "Authentication", text: "Firebase Log Out", visible: loginPage.authenticated},
    { type: "Database", text: "Firebase Write String to DB", visible: loginPage.authenticated},
    { type: "Database", text: "Firebase Write int to DB", visible: loginPage.authenticated },
    { type: "Database", text: "Firebase Write Bool to DB", visible: loginPage.authenticated },
    { type: "Database", text: "Firebase Write flaot to DB", visible: loginPage.authenticated },
    { type: "Database", text: "Firebase Delete from DB", visible: loginPage.authenticated },
    { type: "Database", text: "Firebase Read String from DB", visible: loginPage.authenticated },
    { type: "Database", text: "Firebase Read int from DB", visible: loginPage.authenticated },
    { type: "Database", text: "Firebase Read Bool from DB", visible: loginPage.authenticated },
    { type: "Database", text: "Firebase Read flaot from DB", visible: loginPage.authenticated },
    { type: "Database", text: "Please log in to use the Database!", visible: !loginPage.authenticated },
    { type: "Examples from Docs", text: "Simple Auth"},
    { type: "Examples from Docs", text: "Simple Database"},
    { type: "Examples from Docs", text: "Advanced"}]

  section.property: "type"
  section.delegate: SimpleSection { }

  delegate: SimpleRow {
    onSelected: {
      switch(index) {
      case 0:
        loginPage.opacity = 1
        break
      case 1:
        loginPage.opacity = 1
        break
      case 2:
        loginPage.logoutUser()
        break
      case 3: {
        if(loginPage.authenticated) {
          db.setUserValue("teststring", "test")
        } else {
          console.log("NOT AUTHENTICATED, LOG IN FIRST!")
        }
      }
      break
      case 4: {
        if(loginPage.authenticated) {
          db.setUserValue("testint", 123)
        } else {
          console.log("NOT AUTHENTICATED, LOG IN FIRST!")
        }
        break
      }
      case 5: {
        if(loginPage.authenticated) {
          db.setUserValue("testbool", false)
        } else {
          console.log("NOT AUTHENTICATED, LOG IN FIRST!")
        }
        break
      }
      case 6: {
        if(loginPage.authenticated) {
          db.setUserValue("testfloat", 1.123)
        } else {
          console.log("NOT AUTHENTICATED, LOG IN FIRST!")
        }
        break
      }
      case 7: {
        if(loginPage.authenticated) {
          db.setUserValue("testbool", null)
        } else {
          console.log("NOT AUTHENTICATED, LOG IN FIRST!")
        }
        break
      }
      case 8: {
        if(loginPage.authenticated) {
          db.getUserValue("teststring")
        } else {
          console.log("NOT AUTHENTICATED, LOG IN FIRST!")
        }
        break
      }
      case 9: {
        if(loginPage.authenticated) {
          db.getUserValue("testint")
        } else {
          console.log("NOT AUTHENTICATED, LOG IN FIRST!")
        }
        break
      }
      case 10: {
        if(loginPage.authenticated) {
          db.getUserValue("testbool")
        } else {
          console.log("NOT AUTHENTICATED, LOG IN FIRST!")
        }
        break
      }
      case 11: {
        if(loginPage.authenticated) {
          db.getUserValue("testfloat")
        } else {
          console.log("NOT AUTHENTICATED, LOG IN FIRST!")
        }
        break
      }
      case 13: {
        firebasePage.navigationStack.push(Qt.resolvedUrl("firebase/FirebaseSimpleAuth.qml"))
        break
      }
      case 14: {
        firebasePage.navigationStack.push(Qt.resolvedUrl("firebase/FirebaseSimpleDb.qml"))
        break
      }
      case 15: {
        firebasePage.navigationStack.push(Qt.resolvedUrl("firebase/FirebaseAdvanced.qml"))
        break
      }
      default:
        break
      }
    }
  }

}
