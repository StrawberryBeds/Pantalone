//
//  GameCenterManager.swift
//  Pantalone
//
//  Created by Assistant on 2026-02-24.
//

import Foundation
import GameKit
import UIKit
import Combine

class GameCenterManager: ObservableObject {
    static let shared = GameCenterManager()
    
    @Published var isAuthenticated: Bool = false
    
    init() {}
    
        var localPlayer = GKLocalPlayer.local
    
        var rootViewController: UIViewController? {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            return windowScene?.windows.first?.rootViewController
        }
    
        func authenticateUser() {
            GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
                if let error = error {
                    print("GameLogic - Error authenticating: \(error.localizedDescription)")
                    return
                }
                if let gcAuthVC = gcAuthVC {
                    // Present the authentication view controller if needed
                    self.rootViewController?.present(gcAuthVC, animated: true)
                    return
    
                } else {
                    print("GameLogic - Player authenticated: \(GKLocalPlayer.local.isAuthenticated)")
                }
            }
        }

    func submitScore(_ score: Int, leaderboardIDs: [String]) async {
        if !isAuthenticated {
            print("GameCenterManager - Warning: trying to submit score while not authenticated.")
        }
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

//    func reportAchievement(_ identifier: String, percentComplete: Double = 100.0, showsCompletionBanner: Bool = true) {
//        let achievement = GKAchievement(identifier: identifier)
//        achievement.percentComplete = percentComplete
//        achievement.showsCompletionBanner = showsCompletionBanner
//        GKAchievement.report([achievement]) { error in
//            if let error = error {
//                print("GameCenterManager - Error reporting achievement: \(error.localizedDescription)")
//            } else {
//                print("GameCenterManager - Achievement reported successfully!")
//            }
//        }
//    }
}
