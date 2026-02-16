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
            
            // Game board
            VStack(spacing: 4) {
                ForEach(0..<4) { row in
                    HStack(spacing: 4) {
                        ForEach(0..<3) { col in
                            TileView(
                                tile: viewModel.getTile(at: Position(row: row, col: col)),
                                isPlayable: viewModel.isValidPlayableSpace(row: row, col: col),
                                canMove: viewModel.canMoveTile(at: Position(row: row, col: col)),
                                imageCrop: viewModel.getTile(at: Position(row: row, col: col)).map { viewModel.getImageCrop(for: $0) as! AnyView }
                            )
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    viewModel.moveTile(at: Position(row: row, col: col))
                                }
                            }
                        }
                    }
                }
            }
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

struct TileView: View {
    let tile: Int?
    let isPlayable: Bool
    let canMove: Bool
    let imageCrop: AnyView?
    
    private let tileSize: CGFloat = 100
    
    var body: some View {
        ZStack {
            if isPlayable {
                if let _ = tile, let imageCrop = imageCrop {
                    // Tile with image crop
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .frame(width: tileSize, height: tileSize)
                        .overlay(
                            imageCrop
                                .frame(width: tileSize, height: tileSize)
                                .cornerRadius(8)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(canMove ? Color.blue : Color.gray, lineWidth: canMove ? 3 : 1)
                        )
                        .shadow(radius: canMove ? 5 : 2)
                        .scaleEffect(canMove ? 1.0 : 0.95)
                } else {
                    // Empty space (void)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black.opacity(0.1))
                        .frame(width: tileSize, height: tileSize)
                }
            } else {
                // Non-playable space
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: tileSize, height: tileSize)
            }
        }
    }
}
