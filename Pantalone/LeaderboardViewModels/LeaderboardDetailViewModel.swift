//
//  LeaderboardDetailViewModel.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-04.
//

import SwiftUI
import GameKit
import Combine

class LeaderboardDetailViewModel: ObservableObject {
    let leaderboardID: String
    let leaderboardName: String
    
    @Published var leaderboardEntries: [LeaderboardEntry] = []
    @Published var leaderboardTitle: String = ""
    @Published var isLoading = false
    @Published var loadError: String?
    
    init(leaderboardID: String, leaderboardName: String) {
        self.leaderboardID = leaderboardID
        self.leaderboardName = leaderboardName
    }
    
    func loadLeaderboard() {
        isLoading = true
        loadError = nil
        leaderboardEntries = []
        leaderboardTitle = ""
        
        GKLeaderboard.loadLeaderboards(IDs: [leaderboardID]) { (leaderboards, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.loadError = "Failed to load leaderboard: \(error.localizedDescription)"
                }
                return
            }
            
            guard let leaderboard = leaderboards?.first else {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.loadError = "Leaderboard not found."
                }
                return
            }
            
            let title = leaderboard.title ?? self.leaderboardName
            
            leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(location: 1, length: 10)) { (_, entries, _, error) in
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.leaderboardTitle = title
                    
                    if let error = error {
                        self.loadError = "Failed to load scores: \(error.localizedDescription)"
                        return
                    }
                    
                    if let entries = entries, !entries.isEmpty {
                        self.leaderboardEntries = entries.map {
                            LeaderboardEntry(
                                playerName: $0.player.displayName,
                                score: Int($0.score),
                                rank: $0.rank
                            )
                        }
                    }
                }
            }
        }
    }
}
