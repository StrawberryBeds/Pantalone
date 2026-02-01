//
//  CustomLeaderboardView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-27.
//

import SwiftUI
import GameKit

struct LeaderboardInfo: Identifiable {
    let id: String  // leaderboard ID
    let name: String
    let iconName: String  // SF Symbol name for icon
}

struct CustomLeaderboardView: View {
    @ObservedObject var gameLogic: GameLogic
    
    @State private var availableLeaderboards: [LeaderboardInfo] = []
    @State private var isLoading = false
    @State private var loadError: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    ProgressView("Loading leaderboards...")
                        .padding()
                } else if let error = loadError {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                        Text(error)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            loadAvailableLeaderboards()
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()
                } else if availableLeaderboards.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "list.bullet.clipboard")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                        Text("No leaderboards available")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                } else {
                    List(availableLeaderboards) { leaderboard in
                        NavigationLink(destination: LeaderboardDetailView(
                            leaderboardID: leaderboard.id,
                            leaderboardName: leaderboard.name
                        )) {
                            HStack {
                                Image(systemName: leaderboard.iconName)
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                    .frame(width: 40)
                                
                                Text(leaderboard.name)
                                    .font(.headline)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Leaderboards")
            .onAppear {
                if availableLeaderboards.isEmpty {
                    loadAvailableLeaderboards()
                }
            }
        }
    }
    
    private func loadAvailableLeaderboards() {
        isLoading = true
        loadError = nil
        availableLeaderboards = []
        
        // Get all unique leaderboard IDs from card sets (static property)
        let allLeaderboardIDs = CardDataSource.cardSets.flatMap { $0.leaderboardIDs }
        let uniqueLeaderboardIDs = Array(Set(allLeaderboardIDs))
        
        guard !uniqueLeaderboardIDs.isEmpty else {
            DispatchQueue.main.async {
                self.isLoading = false
                self.loadError = "No leaderboards configured."
            }
            return
        }
        
        // Load all leaderboards
        GKLeaderboard.loadLeaderboards(IDs: uniqueLeaderboardIDs) { (leaderboards, error) in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.loadError = "Failed to load leaderboards: \(error.localizedDescription)"
                    return
                }
                
                guard let leaderboards = leaderboards, !leaderboards.isEmpty else {
                    self.loadError = "No leaderboards found."
                    return
                }
                
                // Map leaderboards to our display model
                self.availableLeaderboards = leaderboards.map { leaderboard in
                    LeaderboardInfo(
                        id: leaderboard.baseLeaderboardID,
                        name: leaderboard.title ?? "Leaderboard",
                        iconName: self.iconForLeaderboard(leaderboard.title ?? "")
                    )
                }
                .sorted { $0.name < $1.name }  // Sort alphabetically
            }
        }
    }
    
    // Helper function to assign icons based on leaderboard name
    private func iconForLeaderboard(_ name: String) -> String {
        let lowercasedName = name.lowercased()
        
        if lowercasedName.contains("emoji") {
            return "face.smiling"
        } else if lowercasedName.contains("bird") {
            return "bird"
        } else if lowercasedName.contains("animal") {
            return "pawprint"
        } else if lowercasedName.contains("flag") {
            return "flag"
        } else if lowercasedName.contains("food") {
            return "fork.knife"
        } else {
            return "trophy"
        }
    }
}
