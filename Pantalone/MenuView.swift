//
//  MenuView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//


import SwiftUI
import GameKit

struct MenuView: View {
    let cardSets = CardDataSource.cardSets
    let customTitle = Font.custom("FrederickatheGreat-Regular", size: 32)
    @State private var selectedCardSet: CardSet? = nil
    @State private var navigationSelection: CardSet? = nil
//    @State private var isGameCenterPresented: Bool = false

    @ObservedObject var gameLogic: GameLogic
    
    let cream = Color("Cream")
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]
    
    var body: some View {

            NavigationStack {
                VStack {
//                    Button("Show Game Center") {
//                        isGameCenterPresented = true
//                    }
//                    .sheet(isPresented: $isGameCenterPresented) {
//                        NavigationStack {
//                            GameCenterView(gameLogic: gameLogic)
//                                .toolbar {
//                                    ToolbarItem(placement: .cancellationAction) {
//                                        Button("Close") {
//                                            isGameCenterPresented = false
//                                        }
//                                    }
//                                }
//                        }
//                    }
                    Text("Choose a set to match!")
                        .font(customTitle)
                
                    LazyVGrid(columns: columns, spacing: 5) {
                        ForEach(cardSets) { cardSet in
                            NavigationLink(
                                tag: cardSet,
                                selection: $navigationSelection,
                                destination: {
                                    ContentView(gameLogic: gameLogic, selectedCardSet: navigationSelection)
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
                                        selectedCardSet = cardSet
                                        gameLogic.selectedCardSet = cardSet
                                        gameLogic.handleReset()
                                        navigationSelection = cardSet
                                    }
                                }
                            )
                        }
                    }
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.accentColor)
                .ignoresSafeArea(edges: .all)
        }
    }
}

