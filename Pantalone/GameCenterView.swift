//
//  GameCenterView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//

import SwiftUI

struct GameCenterView: View {
    var gameLogic: GameLogic

    var body: some View {
        if (gameLogic.selectedCardSet?.leaderboardIDs.first) != nil {
            CustomLeaderboardView(gameLogic: gameLogic)
        } else {
            Text("No leaderboard available.")
        }
    }

    func submitScore() {
        var leaderboardIDs = gameLogic.selectedCardSet?.leaderboardIDs ?? []
        var achievementIDs = gameLogic.selectedCardSet?.achievementIDs ?? []

        if leaderboardIDs.isEmpty {
            gameLogic.selectedCardSet = CardDataSource.cardSets.first { $0.id == 1 }
            leaderboardIDs = gameLogic.selectedCardSet?.leaderboardIDs ?? []
        }

        Task {
            do {
                try await GameCenterManager.shared.submitScore(gameLogic.turns, leaderboardIDs: leaderboardIDs)
                print("GameCenterView - Score submitted successfully: \(leaderboardIDs) \(gameLogic.turns)")
            } catch {
                print("GameCenterView - Failed to submit score: \(error.localizedDescription)")
            }

            if gameLogic.turns <= 16, let achievementID = achievementIDs.first {
                do {
                    try await GameCenterManager.shared.reportAchievement(achievementID, percentComplete: 100.0)
                    print("Achievement reported successfully!")
                } catch {
                    print("Error reporting achievement: \(error.localizedDescription)")
                }
            }
        }
    }
}

