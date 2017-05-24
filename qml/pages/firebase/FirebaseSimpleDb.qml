import VPlayPlugins 1.0
import VPlayApps 1.0
import QtQuick 2.0

Page {

  FirebaseDatabase {
    id: firebaseDb

    onReadCompleted: {
      if(success) {
        console.debug("Read value " +  value + " for key " + key)
        output.text = value
      } else {
        console.debug("Error: "  + value)
      }
    }

    onWriteCompleted: {
      if(success) {
        console.debug("Successfully wrote to DB")
      } else {
        console.debug("Write failed with error: " + message)
      }
    }
  }

  Column {
    anchors.fill: parent

    AppButton {
      text: "Save Value"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: firebaseDb.setValue("public/teststring", "test")
    }

    AppButton {
      text: "Get Value"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: firebaseDb.getValue("public/teststring")
    }

    AppText {
      anchors.left: parent.left
      anchors.right: parent.right
      horizontalAlignment: AppText.AlignHCenter
      id: output
      text: "The value read from the database will be displayed here!"
    }
  }
}// Page
