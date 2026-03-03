//
//  SlideGameViewModel.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-14.
//

import SwiftUI
import Foundation
import GameKit
import Combine

class SlideGameViewModel: ObservableObject {
    @Published private var game: SlideGameLogic
    @Published var moveCount: Int = 0
    @Published var isGameWon: Bool = false
    let selectedImage: SlideImage?
    
    @Published var slideGameOverModalIsPresented : Bool = false
    
    init(selectedImage: SlideImage?) {
        self.selectedImage = selectedImage
        game = SlideGameLogic(selectedImage: selectedImage)
        game.testInitialState()  // Test before shuffle
    }
    
    var tiles: [[Int?]] {
        game.tiles
    }
    
    var emptyPosition: Position {
        game.emptyPosition
    }
    
    func getTile(at position: Position) -> Int? {
        game.getTile(at: position)
    }
    
    func moveTile(at position: Position) {
        if game.moveTile(at: position) {
            moveCount += 1
            objectWillChange.send()  // Force UI update
            checkWinCondition()
        }
    }
    
    func canMoveTile(at position: Position) -> Bool {
        game.canMoveTile(at: position)
    }
    
    func shuffle() {
        game.shuffle()
        moveCount = 0
        isGameWon = false
        objectWillChange.send()  // Force UI update
    }
    
    func resetGame() {
        game = SlideGameLogic(selectedImage: selectedImage)
        moveCount = 0
        isGameWon = false
        objectWillChange.send()  // Force UI update
    }
    
    private func checkWinCondition() {
        if game.isSolved() {
            isGameWon = true
            self.slideGameOverModalIsPresented = true
        }
    }
    
    func isValidPlayableSpace(row: Int, col: Int) -> Bool {
        if row == 3 && col > 0 {
            return false
        }
        return true
    }
    
    func getImageCrop(for tileNumber: Int) -> some View {
        guard let selectedImage = selectedImage else {
            return AnyView(EmptyView())
        }
        
        let row = tileNumber / 3
        let col = tileNumber % 3
        
        return AnyView(
            GeometryReader { geometry in
                Image(selectedImage.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width * 3, height: geometry.size.height * 3)
                    .offset(
                        x: -geometry.size.width * CGFloat(col),
                        y: -geometry.size.height * CGFloat(row)
                    )
                    .clipped()
            }
        )
    }
}
