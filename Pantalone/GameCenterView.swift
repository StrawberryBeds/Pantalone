//
//  GameCenterView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//

import SwiftUI
import GameKit

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
        if leaderboardIDs.isEmpty {
            gameLogic.selectedCardSet = CardDataSource.cardSets.first { $0.id == 1 }
            leaderboardIDs = gameLogic.selectedCardSet?.leaderboardIDs ?? []
        }
        Task {
            do {
                try await GKLeaderboard.submitScore(
                    gameLogic.turns,
                    context: 0,
                    player: GKLocalPlayer.local,
                    leaderboardIDs: leaderboardIDs
                )
                print("GameCenterView - Score submitted successfully: \(leaderboardIDs) \(gameLogic.turns)")
            } catch {
                print("GameCenterView - Failed to submit score: \(error.localizedDescription)")
            }
        }
    }
}

