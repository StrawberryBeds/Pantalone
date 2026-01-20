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
    
    @ObservedObject var gameLogic: GameLogic
    @State var selectedCardSet: CardSet?
    
//    let paperBag = Color("PaperBag")
    let cream = Color("Cream")
    let offWhite = Color("OffWhite")
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        ZStack {
            Color.cream
                .ignoresSafeArea()
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(gameLogic.cards) { card in
                        let isFlipped = gameLogic.flippedIndices.contains(card.id) || gameLogic.solvedIndices.contains(card.id)
                        let cardImage = isFlipped ? card.image : "card_back_bird"
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(Color.offWhite)
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(8)
                            
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
                }
                .padding()
                
                HStack {
                    Text("Turns: \(gameLogic.turns) Matches: \(gameLogic.matches)")
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

//#Preview {
//    ContentView(gameLogic: gameLogic)
//}

