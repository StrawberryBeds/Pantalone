//
//  SlideView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-12.
//

import SwiftUI

struct SlideView: View {
    @StateObject private var viewModel: SlideGameViewModel
    
    init(selectedImage: SlideImage?) {
        _viewModel = StateObject(wrappedValue: SlideGameViewModel(selectedImage: selectedImage))
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("Sliding Puzzle")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Move counter
            Text("Moves: \(viewModel.moveCount)")
                .font(.title2)
                .foregroundColor(.secondary)
            
            // Game board - KEY FIX: Add .id() to force rebuild
            VStack(spacing: 4) {
                ForEach(0..<4) { row in
                    HStack(spacing: 4) {
                        ForEach(0..<3) { col in
                            TileViewWithTap(
                                row: row,
                                col: col,
                                viewModel: viewModel
                            )
                            .id("\(row)-\(col)")  // Unique ID for each tile!
                        }
                    }
                }
            }
            .id(viewModel.moveCount)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
            
            // Buttons
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation {
                        viewModel.shuffle()
                    }
                }) {
                    Text("Shuffle")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 120, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    withAnimation {
                        viewModel.resetGame()
                    }
                }) {
                    Text("Reset")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 120, height: 50)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
        .alert("Congratulations!", isPresented: $viewModel.isGameWon) {
            Button("Play Again") {
                viewModel.shuffle()
            }
            Button("Reset") {
                viewModel.resetGame()
            }
        } message: {
            Text("You solved the puzzle in \(viewModel.moveCount) moves!")
        }
    }
}

struct TileViewWithTap: View {
    let row: Int
    let col: Int
    @ObservedObject var viewModel: SlideGameViewModel
    
    var body: some View {
        let position = Position(row: row, col: col)
        let tile = viewModel.getTile(at: position)
        let isPlayable = viewModel.isValidPlayableSpace(row: row, col: col)
        let canMove = isPlayable && tile != nil &&
                      ((abs(position.row - viewModel.emptyPosition.row) == 1 && position.col == viewModel.emptyPosition.col) ||
                       (abs(position.col - viewModel.emptyPosition.col) == 1 && position.row == viewModel.emptyPosition.row))
        
        Button(action: {
            print("SlideView - Position (\(row), \(col)) tapped")
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                viewModel.moveTile(at: Position(row: row, col: col))
            }
        }) {
            TileView(
                tile: tile,
                isPlayable: isPlayable,
                canMove: canMove,
                imageCrop: tile.map { viewModel.getImageCrop(for: $0) as! AnyView },
                position: position
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TileView: View {
    let tile: Int?
    let isPlayable: Bool
    let canMove: Bool
    let imageCrop: AnyView?
    let position: Position
    
    private let tileSize: CGFloat = 100
    
    var body: some View {
        ZStack {
            if isPlayable {
                if let tileNumber = tile {
                    // Tile with number (no image for now - just debugging)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(canMove ? Color.blue : Color.gray)
                        .frame(width: tileSize, height: tileSize)
                        .overlay(
                            VStack {
                                Text("T\(tileNumber)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text("(\(position.row),\(position.col))")
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        )
                } else {
                    // Empty space
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black.opacity(0.1))
                        .frame(width: tileSize, height: tileSize)
                        .overlay(
                            Text("EMPTY\n(\(position.row),\(position.col))")
                                .font(.caption2)
                                .foregroundColor(.gray)
                        )
                }
            } else {
                // Non-playable
                Rectangle()
                    .fill(Color.red.opacity(0.3))
                    .frame(width: tileSize, height: tileSize)
            }
        }
        .contentShape(Rectangle())  // CRITICAL: Makes entire frame tappable
    }
}
