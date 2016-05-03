import VPlayApps 1.0
import VPlayPlugins 1.0
import QtQuick 2.0

ListPage {
  title: "GameCenter Plugin"

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
      if (index === 0) {
        gamecenter.authenticateLocalPlayer()
      }
      else if (index === 1) {
        gamecenter.showLeaderboard()
      }
      else if (index === 2) {
        gamecenter.reportScore(25, "leaderboard_main")
      }
      else if (index === 3) {
        gamecenter.showAchievements()
      }
      else if (index === 4) {
        gamecenter.reportAchievement("achievement_1", 100, true)
      }
      else if (index === 5) {
        gamecenter.resetAchievements()
      }
    }
  }

  section.property: "section"
  section.delegate: SimpleSection { }

  GameCenter {
    id: gamecenter

    onAuthenticatedChanged: console.debug("User is authenticated:", authenticated)
    onAchievementReported: console.debug("Achievement reported with success:", success)
    onScoreReported: console.debug("Score reported with success:", success)
    onAchievementsReset: console.debug("Achievements reset with success:", success)
  }
}
