//
//  LeaderboardInfo.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-04.
//

import SwiftUI
import SwiftData

struct LeaderboardInfo: Identifiable {
    let id: String          // leaderboard ID
    let name: String
    let setImage: String    // Card set representative image (e.g. mallard for Birds)
    let cardImage: String   // Specific card image — same as setImage for Match, card-specific for Slide
    let gameType: String
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let playerName: String
    let score: Int
    let rank: Int

    init(playerName: String, score: Int, rank: Int) {
        self.playerName = playerName
        self.score = score
        self.rank = rank
    }
}
