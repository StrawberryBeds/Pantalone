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
//    @State private var isPresenting = false
    @State private var selectedCardSet: CardSet?
    
    @State private var isGameCenterPresented: Bool = false

    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        NavigationStack {
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(gameLogic.cards) { card in
                        let isFlipped = gameLogic.flippedIndices.contains(card.id) || gameLogic.solvedIndices.contains(card.id)
                        let cardImage = isFlipped ? card.image : "card_back_bird"

                        Image(cardImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                            .onTapGesture {
                                gameLogic.handleCardClick(card.id)
                            }
                    }
                }
                .padding()

                HStack {
                    Text("Turns: \(gameLogic.turns) Matches: \(gameLogic.matches)")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            .onAppear(perform: gameLogic.handleReset)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: MenuView(selectedCardSet: $selectedCardSet, gameLogic: gameLogic)) {
                        Label("", systemImage: "house.fill")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isGameCenterPresented = true }) {
                        Label("", systemImage: "trophy.fill")
                    }
                }
            }
            .sheet(isPresented: $isGameCenterPresented) {
                GameCenterView(gameLogic: gameLogic)
            }
//            .sheet(isPresented: $isPresenting) {
//                MenuView(selectedCardSet: $selectedCardSet, gameLogic: gameLogic)
//            }
        }
    }
}

