import VPlayPlugins 1.0
import VPlayApps 1.0
import QtQuick 2.0

Page {

  /* Dummy FirebaseAuth item, which is only required within plugin demo.
     FirebaseDatbase of this example otherwise gets confused by FirebaseAuth items of other examples. */
  FirebaseAuth {
    id: firebaseAuth
  }

  FirebaseDatabase {
    id: firebaseDb

    // set a list of realtime value keys, for which we want to get notified when they are changed on the server
    Component.onCompleted: {
      realtimeValueKeys = [ "public/teststring", "public/news" ]
    }

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

    onRealtimeValueChanged: {
      console.debug("Realtime value changed to " + value)
      output.text = value
    }
  }

  Column {
    anchors.fill: parent

    AppButton {
      text: "Save Value"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: firebaseDb.setValue("public/teststring", "Last Update: " + new Date().toLocaleString())
    }

    AppButton {
      text: "Read Value Once"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: firebaseDb.getValue("public/teststring")
    }

    AppButton {
      text: "Remove Value-Changed Listener"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: {
        firebaseDb.removeRealtimeValueKey("public/teststring")
        output.text = "Click the \"Save Value\" Button to change the value in the DB. The value will be automatically updated here!"
      }
    }

    AppButton {
      text: "Add Value-Changed Listener again"
      anchors.horizontalCenter: parent.horizontalCenter
      onClicked: {
        firebaseDb.addRealtimeValueKey("public/teststring")
        output.text = "Click the \"Save Value\" Button to change the value in the DB. The value will be automatically updated here!"
      }
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
