//
//  MenuView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//

import SwiftUI
import GameKit
import Combine

struct MenuView: View {
    @StateObject var viewModel: MenuViewModel
    
    let customTitle = Font.custom("FrederickatheGreat-Regular", size: 36)
    let cream = Color("Cream")
    let pantalonePink = Color("PantalonePink")
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
    ]
    
    init(gameLogic: GameLogic) {
        _viewModel = StateObject(wrappedValue: MenuViewModel(gameLogic: gameLogic))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Match!")
                    .font(customTitle)
                    .foregroundColor(.black)
                Text("Match them all to win!")
                    .bold()
                    .foregroundColor(.black)
                
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(viewModel.cardSets) { cardSet in
                        NavigationLink(
                            tag: cardSet,
                            selection: $viewModel.navigationSelection,
                            destination: {
                                ContentView(
                                    gameLogic: viewModel.gameLogic,
                                    menuViewModel: viewModel,
                                    selectedCardSet: viewModel.navigationSelection
                                )
                            },
                            label: {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.cream)
                                        .scaledToFit()
                                        .frame(width: 160, height: 160)
                                        .cornerRadius(16)
                                    Image(cardSet.setImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                        .cornerRadius(16)
                                }
                                .onTapGesture {
                                    viewModel.selectCardSet(cardSet)
                                }
                            }
                        )
                    }
                }
                
                // Pass the first available cardSet (or selectedCardSet if one is selected)
                if let cardSet = viewModel.selectedCardSet ?? viewModel.cardSets.first {
                    SlideMenuView(cardSet: cardSet)
                }
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.pantalonePink)
            .ignoresSafeArea(edges: .all)
        }
    }
}
