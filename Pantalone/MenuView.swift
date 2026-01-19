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
    @Binding var selectedCardSet: CardSet?
    @Binding var isPresenting: Bool
    @ObservedObject var gameLogic: GameLogic
    
    let cream = Color("Cream")
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(cardSets) { cardSet in
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
                        isPresenting.toggle()
                    }
                }
            }
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.accentColor)
        .ignoresSafeArea(edges: .all)
    }
}

