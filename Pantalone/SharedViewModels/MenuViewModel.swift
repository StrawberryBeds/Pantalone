//
//  MenuViewModel.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-04.
//


import SwiftUI
import GameKit
import Combine

class MenuViewModel: ObservableObject {
    let cardSets = CardDataSource.cardSets
    @Published var selectedCardSet: CardSet? = nil
    @Published var navigationSelection: CardSet? = nil
    let gameLogic: GameLogic
    
    init(gameLogic: GameLogic) {
        self.gameLogic = gameLogic
    }
    
    func selectCardSet(_ cardSet: CardSet) {
        selectedCardSet = cardSet
        gameLogic.selectedCardSet = cardSet
        gameLogic.handleReset()
        navigationSelection = cardSet
    }
}

