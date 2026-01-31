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
    @State private var leaderboardTitle: String = ""
    @State private var isLoading = false
    @State private var loadError: String?
    
    var body: some View {
        VStack {
            // Display leaderboard title
            if !leaderboardTitle.isEmpty {
                Text(leaderboardTitle)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
            }
            
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
            
//            Button("View Full Leaderboards in Game Center") {
//                isGameCenterPresented = true
//            }
//            .sheet(isPresented: $isGameCenterPresented) {
//                NavigationStack {
//                    GameCenterView(gameLogic: gameLogic)
//                        .toolbar {
//                            ToolbarItem(placement: .cancellationAction) {
//                                Button("Close") {
//                                    isGameCenterPresented = false
//                                }
//                            }
//                        }
//                }
//            }
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
        leaderboardTitle = ""
        
        // Use the non-deprecated method
        GKLeaderboard.loadLeaderboards(IDs: [leaderboardID]) { [self] (leaderboards, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.loadError = error.localizedDescription
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
            let title = leaderboard.title ?? "Leaderboard"
            
            // Load entries for the leaderboard
            leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(location: 1, length: 10)) { (localPlayerEntry, entries, totalPlayerCount, error) in
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.leaderboardTitle = title
                    
                    if let error = error {
                        self.loadError = error.localizedDescription
                        return
                    }
                    
                    if let entries = entries, !entries.isEmpty {
                        self.leaderboardEntries = entries.map {
                            LeaderboardEntry(playerName: $0.player.displayName, score: Int($0.score))
                        }
                    } else {
                        self.loadError = "No scores available."
                    }
                }
            }
        }
    }
}
