//
//  GameCenterView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//


import SwiftUI
import GameKit

struct GameCenterView: UIViewControllerRepresentable {
    // Remove the local var, use the passed instance
    var gameLogic: GameLogic

    func makeUIViewController(context: Context) -> GKGameCenterViewController {
        let gcViewController = GKGameCenterViewController()
        gcViewController.gameCenterDelegate = context.coordinator
        gcViewController.viewState = .leaderboards
        return gcViewController
    }

    func updateUIViewController(_ uiViewController: GKGameCenterViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, GKGameCenterControllerDelegate {
        var parent: GameCenterView

        init(_ parent: GameCenterView) {
            self.parent = parent
        }

        func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
            gameCenterViewController.dismiss(animated: true, completion: nil)
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


