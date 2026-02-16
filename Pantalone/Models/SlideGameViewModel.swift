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
    
    init(selectedImage: SlideImage?) {
        self.selectedImage = selectedImage
        game = SlideGameLogic(selectedImage: selectedImage)
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
    }
    
    func resetGame() {
        game = SlideGameLogic(selectedImage: selectedImage)
        moveCount = 0
        isGameWon = false
    }
    
    private func checkWinCondition() {
        if game.isSolved() {
            isGameWon = true
        }
    }
    
    func isValidPlayableSpace(row: Int, col: Int) -> Bool {
        // Bottom row only has 1 playable space (column 0)
        if row == 3 && col > 0 {
            return false
        }
        return true
    }
    
    // Get the cropped portion of the image for a specific tile
    func getImageCrop(for tileNumber: Int) -> some View {
        guard let selectedImage = selectedImage else {
            return AnyView(EmptyView())
        }
        
        // Calculate which part of the 3x3 grid this tile belongs to
        let row = tileNumber / 3
        let col = tileNumber % 3
        
        let cropSize: CGFloat = 500 / 3  // Each tile is 166.67px of the 500px image
        
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
