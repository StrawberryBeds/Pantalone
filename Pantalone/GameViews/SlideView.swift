//
//  SlideView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-12.
//

import SwiftUI

struct SlideView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @StateObject private var viewModel: SlideGameViewModel
    let customTitle = Font.custom("FrederickatheGreat-Regular", size: 36)
    let customHeadline = Font.custom("FrederickatheGreat-Regular", size: 28)
    
    let cream = Color("Cream")
    let pantalonePink = Color("PantalonePink")
    
    init(selectedImage: SlideImage?) {
        _viewModel = StateObject(wrappedValue: SlideGameViewModel(selectedImage: selectedImage))
    }
    
    var body: some View {
        ZStack {
            Color.cream
                .ignoresSafeArea()
            VStack(spacing: 20) {
                // Title
                Text("Slide")
                    .foregroundColor(.black)
                    .font(customTitle)
                // Move counter
                Text("Moves: \(viewModel.moveCount)")
                    .foregroundColor(.black)
                    .font(customHeadline)
                
                // Game board
                VStack(spacing: 4) {
                    ForEach(0..<4) { row in
                        HStack(spacing: 4) {
                            ForEach(0..<3) { col in
                                TileViewWithTap(
                                    row: row,
                                    col: col,
                                    viewModel: viewModel
                                )
                                .id("\(row)-\(col)")
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
                            .buttonStyle(.borderedProminent)
                            .foregroundColor(.black)
                            .frame(width: 120, height: 50)
                            .background(Color.pantalonePink)
                            .cornerRadius(30)
                    }
                    
                    Button(action: {
                        withAnimation {
                            viewModel.resetGame()
                        }
                    }) {
                        Text("Reset")
                            .buttonStyle(.borderedProminent)
                            .foregroundColor(.black)
                            .frame(width: 120, height: 50)
                            .background(Color.pantalonePink)
                            .cornerRadius(30)
                    }
                }
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.slideGameOverModalIsPresented) {
            SlideGameOverModal(slideGameViewModel: viewModel)
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
                if let tileNumber = tile, let imageCrop = imageCrop {
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
                                .stroke(canMove ? Color.pantalonePink : Color.clear, lineWidth: canMove ? 3 : 0)
                        )
                        .shadow(radius: canMove ? 5 : 2)
                } else {
                    // Empty space (void)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black.opacity(0.15))
                        .frame(width: tileSize, height: tileSize)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                .foregroundColor(.gray)
                        )
                }
            } else {
                // Non-playable space
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: tileSize, height: tileSize)
            }
        }
        .contentShape(Rectangle())  // CRITICAL: Makes entire frame tappable
    }
}
