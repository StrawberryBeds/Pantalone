//
//  CustomLeaderboardViewModel.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-04.
//

import SwiftUI
import GameKit
import Combine

class CustomLeaderboardViewModel: ObservableObject {
    @Published var availableLeaderboards: [LeaderboardInfo] = []
    @Published var isLoading = false
    @Published var loadError: String?
    
    private let cardSets: [CardSet]
    
    init(cardSets: [CardSet]) {
        self.cardSets = cardSets
    }
    
    func loadAvailableLeaderboards() {
        isLoading = true
        loadError = nil
        availableLeaderboards = []
        
        // Get all unique leaderboard IDs from card sets — both Match and Slide
        let allLeaderboardIDs = cardSets.flatMap { $0.leaderboardIDs + $0.slideLeaderboardIDs }
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
                
                self.availableLeaderboards = leaderboards.map { leaderboard in
                    let lbID = leaderboard.baseLeaderboardID

                    // Find the matching card set and whether this is a Slide leaderboard
                    for cardSet in self.cardSets {
                        // Check Match leaderboards
                        if cardSet.leaderboardIDs.contains(lbID) {
                            return LeaderboardInfo(
                                id: lbID,
                                name: leaderboard.title ?? "Leaderboard",
                                setImage: cardSet.setImage,
                                cardImage: cardSet.setImage
                            )
                        }
                        // Check Slide leaderboards — look up the specific card image by index
                        if let index = cardSet.slideLeaderboardIDs.firstIndex(of: lbID) {
                            return LeaderboardInfo(
                                id: lbID,
                                name: leaderboard.title ?? "Leaderboard",
                                setImage: cardSet.setImage,
                                cardImage: cardSet.cardImages[index]
                            )
                        }
                    }

                    // Fallback — should not normally be reached
                    return LeaderboardInfo(
                        id: lbID,
                        name: leaderboard.title ?? "Leaderboard",
                        setImage: "card_back_bird",
                        cardImage: "card_back_bird"
                    )
                }
                .sorted { $0.name < $1.name }
            }
        }
    }

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
