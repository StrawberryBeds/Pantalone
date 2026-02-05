//
//  GameLogic.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//


import Foundation
import GameKit
import Combine

class GameLogic: ObservableObject {
    @Published var cards: [Card] = []
    @Published var flippedIndices: [Int] = []
    @Published var solvedIndices: [Int] = []
    @Published var turns: Int = 0
    @Published var matches: Int = 0
    
    var localPlayer = GKLocalPlayer.local
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { gcAuthVC, error in
            if let error = error {
                print("GameLogic - Error authenticating: \(error.localizedDescription)")
                return
            }
            if let gcAuthVC = gcAuthVC {
                // Present the authentication view controller if needed
                self.rootViewController?.present(gcAuthVC, animated: true)
                return
                
            } else {
                print("GameLogic - Player authenticated: \(GKLocalPlayer.local.isAuthenticated)")
            }
        }
    }
    
    
    // Ensure selectedCardSet is accessible within the class
    var selectedCardSet: CardSet?

    
    func handleCardClick(_ id: Int) {
        
        _ = GameCenterView(gameLogic: self)
        // If the card is already flipped or solved, do nothing
        if flippedIndices.contains(id) || solvedIndices.contains(id) {
            return
        }
        
        // Flip the card
        flippedIndices.append(id)
        
        // Check if two cards are flipped
        if flippedIndices.count == 2 {
            let firstIndex = flippedIndices[0]
            let firstCard = cards.first { $0.id == firstIndex }
            let clickedCard = cards.first { $0.id == id }
            
            // Increment turns
            turns += 1
            
            // Check if the two flipped cards match
            if firstCard?.image == clickedCard?.image {
                // Cards match, add them to solvedIndices
                solvedIndices.append(contentsOf: [firstIndex, id])
                // Increment matches
                matches += 1
            }
            
            // Reset flipped indices after a delay to allow the user to see the second card
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.flippedIndices.removeAll()
                
                if self.solvedIndices.count == self.cards.count {
                    print("GameLogic - You won!")
                    let gameCenterView = GameCenterView(gameLogic: self)
                    gameCenterView.submitScore()
                }

                
            }
        }
    }
    
    func endGame() -> Bool {
        return solvedIndices.count == cards.count
    }
    
    func handleReset() {
        // Reset the game state with the selected card set
        cards = generateCards()
        flippedIndices.removeAll()
        solvedIndices.removeAll()
        turns = 0
        matches = 0
    }
    
    func generateCards() -> [Card] {
         // Use the selected card set or default to the first card set
         let cardSet = selectedCardSet ?? CardDataSource.cardSets.first!
         // Create pairs of cards and shuffle them
         let pairs = (cardSet.cardImages + cardSet.cardImages).shuffled().enumerated().map { index, image in
             Card(id: index, image: image)
         }
         return pairs
     }
    
    func didDismiss() {
        // Handle the dismissing action.
    }
}
