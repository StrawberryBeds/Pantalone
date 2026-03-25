//
//  MenuViewModel.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-04.
//

import SwiftUI
import GameKit
import Combine

var sortedCardSets: [CardSet] {
    CardDataSource.cardSets.sorted(by: { $0.id > $1.id })
}

class MenuViewModel: ObservableObject {
    let cardSets = sortedCardSets
    @Published var selectedCardSet: CardSet? = nil
    @Published var navigationSelection: CardSet? = nil
    let gameLogic: MatchGameLogic
    
    init(gameLogic: MatchGameLogic) {
        self.gameLogic = gameLogic
    }
    
    func selectCardSet(_ cardSet: CardSet) {
        selectedCardSet = cardSet
        gameLogic.selectedCardSet = cardSet
        gameLogic.handleReset()
        navigationSelection = cardSet
    }
}

// Simplified SlideImage - now just references data from CardSet
struct SlideImage: Identifiable, Equatable, Hashable {
    let id: Int
    let cardSetName: String
    let cardName: String
    let leaderboardID: String
    let imageName: String
    
    // Convenience initializer from CardSet and index
    init(cardSet: CardSet, index: Int) {
        self.id = (cardSet.id * 100) + index  // Unique ID: cardSet.id * 100 + position
        self.cardSetName = cardSet.setName
        self.cardName = cardSet.cardNames[index]
        self.leaderboardID = cardSet.slideLeaderboardIDs[index]
        self.imageName = cardSet.cardImages[index]
    }
}

class SlideMenuViewModel: ObservableObject {
    let cardSet: CardSet
    let slideImages: [SlideImage]
    @Published var selectedSlideImage: SlideImage? = nil
    @Published var navigationSelection: SlideImage? = nil
    
    init(cardSet: CardSet) {
        self.cardSet = cardSet
        // Generate SlideImages from the CardSet
        self.slideImages = cardSet.cardImages.enumerated().map { index, _ in
            SlideImage(cardSet: cardSet, index: index)
        }
    }
    
    func selectSlideImage(_ slideImage: SlideImage) {
        selectedSlideImage = slideImage
        navigationSelection = slideImage
    }
}
