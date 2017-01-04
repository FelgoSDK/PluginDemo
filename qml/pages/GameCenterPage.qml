import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0
import "../helper"

ListPage {
  title: "GameCenter Plugin"

  listView.header: Column {
    width: parent.width

    SectionDescription { text: "Integrate with GameCenter to send your games' highscores from V-Play Game Network to Apple Game Center on iOS devices." }
    SectionContent {
      contentItem: AppImage {
        width: sourceSize.width * dp(1) * 0.75
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/code-gamecenter.png")
      }
    }
    SectionContent {
      contentItem: AppImage {
        anchors.horizontalCenter: parent.horizontalCenter
        width: sourceSize.width * dp(1) * 0.5
        height: width / sourceSize.width * sourceSize.height
        source: Qt.resolvedUrl("../../assets/logo-gamecenter.png")
      }
    }

    SectionHeader { text: "Example" }
  }

  model: ListModel {
    ListElement { section: "Game Center"; name: "Authenticate" }
    ListElement { section: "Scores"; name: "Show Leaderboard" }
    ListElement { section: "Scores"; name: "Report Score (25)" }
    ListElement { section: "Achievements"; name: "Show Achievements" }
    ListElement { section: "Achievements"; name: "Report Achievement" }
    ListElement { section: "Achievements"; name: "Reset Achievements" }
  }

  delegate: SimpleRow {
    text: name

    onSelected: {
      // if user is not authenticated, show a message box that he cannot use GameCenter features
      if(index > 0 && !gamecenter.authenticated) {
        NativeDialog.confirm("Not Authenticated",
                             "Log in with your account to use GameCenter. Do you want to log in now?",
                             function(ok) {
                               if(ok)
                                 gamecenter.authenticateLocalPlayer()
                             })
        return
      }

      // default clicked behavior
      if (index === 0) {
        if(gamecenter.authenticated)
          NativeDialog.confirm("Already Authenticated", "You are already authenticated.", function(){}, false)
        else
          gamecenter.authenticateLocalPlayer()
      }
      else if (index === 1) {
        gamecenter.showLeaderboard()
      }
      else if (index === 2) {
        gamecenter.reportScore(25, Constants.gcLeaderboardID)
      }
      else if (index === 3) {
        gamecenter.showAchievements()
      }
      else if (index === 4) {
        gamecenter.reportAchievement(Constants.gcAchievementID, 100, true)
      }
      else if (index === 5) {
        gamecenter.resetAchievements()
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection {
    // show authentication status in first section title
    title: {
      if(section === "Game Center")
        return section + (gamecenter.authenticated ? " (Authenticated)" : " (Not Authenticated)")
      else
        return section
    }
  }

  GameCenter {
    id: gamecenter

    onAuthenticatedChanged: NativeDialog.confirm("GameCenter", "User is authenticated: "+authenticated, function() { }, false)
    onAchievementReported: NativeDialog.confirm("GameCenter", "Achievement reported with success: "+success, function() { }, false)
    onScoreReported: NativeDialog.confirm("GameCenter", "Score reported with success: "+success, function() { }, false)
    onAchievementsReset: NativeDialog.confirm("GameCenter", "Achievements reset with success: "+success, function() { }, false)
  }

  // automatically call authenticate when page is created/opened
  Component.onCompleted: {
    if(!gamecenter.authenticated)
      gamecenter.authenticateLocalPlayer()
  }
}
