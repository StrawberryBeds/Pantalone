//
//  SlideGameLogic.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-12.
//

import Foundation
import GameKit
import Combine
import SwiftUI

struct Position: Equatable {
    let row: Int
    let col: Int
}

class SlideGameLogic {
    private(set) var tiles: [[Int?]]
    private(set) var emptyPosition: Position
    let rows = 4
    let cols = 3
    var selectedImage: SlideImage?
    
    init(selectedImage: SlideImage? = nil) {
        self.selectedImage = selectedImage
        // 9 tiles (0-8) + 1 void
        tiles = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [nil, nil, nil]  // First is void, others are non-playable
        ]
        
        emptyPosition = Position(row: 3, col: 0)
    }
    
    func shuffle(moves: Int = 200) {
        for _ in 0..<moves {
            let validMoves = getValidMoves()
            if let randomMove = validMoves.randomElement() {
                _ = moveTile(at: randomMove)
            }
        }
    }
    
    func getValidMoves() -> [Position] {
        var moves: [Position] = []
        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        
        for (dRow, dCol) in directions {
            let newRow = emptyPosition.row + dRow
            let newCol = emptyPosition.col + dCol
            
            if isValidPlayableSpace(row: newRow, col: newCol),
               tiles[newRow][newCol] != nil {
                moves.append(Position(row: newRow, col: newCol))
            }
        }
        
        return moves
    }
    
    func moveTile(at position: Position) -> Bool {
        guard canMoveTile(at: position) else { return false }
        
        tiles[emptyPosition.row][emptyPosition.col] = tiles[position.row][position.col]
        tiles[position.row][position.col] = nil
        emptyPosition = position
        
        return true
    }
    
    func canMoveTile(at position: Position) -> Bool {
        guard isValidPlayableSpace(row: position.row, col: position.col),
              tiles[position.row][position.col] != nil else {
            return false
        }
        
        let rowDiff = abs(position.row - emptyPosition.row)
        let colDiff = abs(position.col - emptyPosition.col)
        
        return (rowDiff == 1 && colDiff == 0) || (rowDiff == 0 && colDiff == 1)
    }
    
    func isSolved() -> Bool {
        let solvedState: [[Int?]] = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [nil, nil, nil]
        ]
        
        for row in 0..<rows {
            for col in 0..<cols {
                if tiles[row][col] != solvedState[row][col] {
                    return false
                }
            }
        }
        return true
    }
    
    // Check if position is within the playable area
    private func isValidPlayableSpace(row: Int, col: Int) -> Bool {
        guard row >= 0 && row < rows && col >= 0 && col < cols else {
            return false
        }
        
        // Bottom row only has 1 playable space (column 0 - the void)
        if row == 3 && col > 0 {
            return false
        }
        
        return true
    }
    
    func getTile(at position: Position) -> Int? {
        guard isValidPlayableSpace(row: position.row, col: position.col) else {
            return nil
        }
        return tiles[position.row][position.col]
    }
    
    func printBoard() {
        for (rowIndex, row) in tiles.enumerated() {
            let printRow = row.enumerated().map { (colIndex, tile) -> String in
                if rowIndex == 3 && colIndex > 0 {
                    return "  "  // Non-playable space
                }
                return tile == nil ? "[]" : String(format: "%2d", tile!)
            }
            print(printRow.joined(separator: " "))
        }
        print()
    }
}
