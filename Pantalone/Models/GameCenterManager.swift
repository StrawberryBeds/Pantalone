//
//  GameCenterManager.swift
//  Pantalone
//
//  Created by Assistant on 2026-02-24.
//

import Foundation
import GameKit
import UIKit

class GameCenterManager {
    static let shared = GameCenterManager()
    
    private init() {}
    
    var localPlayer: GKLocalPlayer {
        return GKLocalPlayer.local
    }
    
    func authenticateUser(presentingViewController: UIViewController?) {
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
            if let error = error {
                print("GameCenterManager - Error authenticating: \(error.localizedDescription)")
                return
            }
            if let gcAuthVC = gcAuthVC, let viewController = presentingViewController {
                viewController.present(gcAuthVC, animated: true)
                return
            } else {
                print("GameCenterManager - Player authenticated: \(GKLocalPlayer.local.isAuthenticated)")
            }
        }
    }

    func submitScore(_ score: Int, leaderboardIDs: [String]) async {
        do {
            try await GKLeaderboard.submitScore(
                score,
                context: 0,
                player: GKLocalPlayer.local,
                leaderboardIDs: leaderboardIDs
            )
            print("GameCenterManager - Score submitted successfully: \(leaderboardIDs) \(score)")
        } catch {
            print("GameCenterManager - Failed to submit score: \(error.localizedDescription)")
        }
    }

    func reportAchievement(_ identifier: String, percentComplete: Double = 100.0, showsCompletionBanner: Bool = true) {
        let achievement = GKAchievement(identifier: identifier)
        achievement.percentComplete = percentComplete
        achievement.showsCompletionBanner = showsCompletionBanner
        GKAchievement.report([achievement]) { error in
            if let error = error {
                print("GameCenterManager - Error reporting achievement: \(error.localizedDescription)")
            } else {
                print("GameCenterManager - Achievement reported successfully!")
            }
        }
    }
}
