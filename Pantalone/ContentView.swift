//
//  ContentView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//

import SwiftUI
import SwiftData
import GameKit

struct ContentView: View {
    
    @StateObject var gameLogic = GameLogic()
    @State private var isPresenting = false
    @State private var selectedCardSet: CardSet?
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        NavigationView {
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(gameLogic.cards) { card in
                        let isFlipped = gameLogic.flippedIndices.contains(card.id) || gameLogic.solvedIndices.contains(card.id)
                        let cardImage = isFlipped ? card.image : "card_back_bird"

                        Image(cardImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .onTapGesture {
                                gameLogic.handleCardClick(card.id)
                            }
                    }
                }
                .padding()

                HStack {
                    Text("Turns: \(gameLogic.turns) Matches: \(gameLogic.matches)")
                        .font(.headline)
                        .foregroundColor(.white)
                }
//                Button("Submit Score") {
//                    let gameCenterView = GameCenterView(gameLogic: gameLogic)
//                    gameCenterView.submitScore()
//                }
            }
            .onAppear(perform: gameLogic.handleReset)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Menu") {
                        isPresenting.toggle()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("New Game", action: gameLogic.handleReset)
                }
            }
            .sheet(isPresented: $isPresenting) {
                MenuView(isPresenting: $isPresenting, selectedCardSet: $selectedCardSet, gameLogic: gameLogic)
            }
        }
    }
}
