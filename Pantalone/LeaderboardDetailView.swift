//
//  LeaderboardDetailView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-31.
//

import SwiftUI
import GameKit

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let playerName: String
    let score: Int
    let rank: Int
}

struct LeaderboardDetailView: View {
    let leaderboardID: String
    let leaderboardName: String
    
    @State private var leaderboardEntries: [LeaderboardEntry] = []
    @State private var leaderboardTitle: String = ""
    @State private var isLoading = false
    @State private var loadError: String?
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .padding()
            } else if let error = loadError {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    Text(error)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
            } else if leaderboardEntries.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "trophy")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("No scores yet")
                        .foregroundColor(.secondary)
                    Text("Be the first to play!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
            } else {
                List {
                    ForEach(leaderboardEntries) { entry in
                        HStack {
                            // Rank badge
                            Text("#\(entry.rank)")
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .frame(width: 50, alignment: .leading)
                            
                            // Player name
                            Text(entry.playerName)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            // Score
                            Text("\(entry.score)")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(leaderboardTitle.isEmpty ? leaderboardName : leaderboardTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if leaderboardEntries.isEmpty {
                loadLeaderboard()
            }
        }
    }
    
    private func loadLeaderboard() {
        isLoading = true
        loadError = nil
        leaderboardEntries = []
        leaderboardTitle = ""
        
        // Use the non-deprecated method
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
            
            // Capture the leaderboard title
            let title = leaderboard.title ?? leaderboardName
            
            // Load entries for the leaderboard
            leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(location: 1, length: 10)) { (localPlayerEntry, entries, totalPlayerCount, error) in
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
                    // If empty, the UI will show "No scores yet"
                }
            }
        }
    }
}
