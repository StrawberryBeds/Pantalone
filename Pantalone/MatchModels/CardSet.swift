//
//  CardSet.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//


import SwiftUI
import SwiftData

struct CardSet: Identifiable, Equatable, Hashable {
    let id: Int
    let setName: String
    let setImage: String
    let cardImages: [String]
    let leaderboardIDs: [String]
}
