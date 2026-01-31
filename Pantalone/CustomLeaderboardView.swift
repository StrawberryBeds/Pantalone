//
//  CustomLeaderboardView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-27.
//

import SwiftUI
import GameKit

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let playerName: String
    let score: Int
}

struct CustomLeaderboardView: View {
    
    @State private var isGameCenterPresented: Bool = false
    @ObservedObject var gameLogic: GameLogic
    
    @State private var leaderboardEntries: [LeaderboardEntry] = []
    @State private var isLoading = false
    @State private var loadError: String?
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .padding()
            } else if let error = loadError {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(leaderboardEntries) { entry in
                    HStack {
                        Text(entry.playerName)
                        Spacer()
                        Text("\(entry.score)")
                    }
                    .padding(.vertical, 4)
                }
            }
            
            Button("View Full Leaderboards in Game Center") {
                isGameCenterPresented = true
            }
            .sheet(isPresented: $isGameCenterPresented) {
                NavigationStack {
                    GameCenterView(gameLogic: gameLogic)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Close") {
                                    isGameCenterPresented = false
                                }
                            }
                        }
                }
            }
        }
        .onAppear {
            if leaderboardEntries.isEmpty {
                loadLeaderboard()
            }
        }
    }
    
    private func loadLeaderboard() {
        guard let leaderboardID = gameLogic.selectedCardSet?.leaderboardIDs.first else {
            loadError = "No leaderboard available."
            return
        }
        isLoading = true
        loadError = nil
        leaderboardEntries = []
        Task {
            do {
                let leaderboards = try await GKLeaderboard.loadLeaderboards()
                guard let leaderboard = leaderboards.first(where: { $0.baseLeaderboardID == leaderboardID || $0.identifier == leaderboardID }) else {
                    await MainActor.run {
                        isLoading = false
                        loadError = "Leaderboard not found."
                    }
                    return
                }
                let (localPlayerEntry, entries, _) = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(location: 1, length: 10))
                await MainActor.run {
                    isLoading = false
                    if !entries.isEmpty {
                        leaderboardEntries = entries.map {
                            LeaderboardEntry(playerName: $0.player.displayName, score: Int($0.score))
                        }
                    } else {
                        loadError = "No scores available."
                    }
                }
            } catch {
                await MainActor.run {
                    isLoading = false
                    loadError = error.localizedDescription
                }
            }
        }
    }
}

