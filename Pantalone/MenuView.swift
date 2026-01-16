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
    @Binding var isPresenting: Bool
    @Binding var selectedCardSet: CardSet?
    @ObservedObject var gameLogic: GameLogic
    
    @State private var isGameCenterPresented: Bool = false
    
    var body: some View {
        VStack {
            ForEach(cardSets) { cardSet in
                Text(cardSet.setName)
                    .foregroundColor(.white)
                    .padding()
                    .onTapGesture {
                        selectedCardSet = cardSet
                        gameLogic.selectedCardSet = cardSet
                        gameLogic.handleReset()
                        isPresenting.toggle()
                    }
            }
            
            Text("Game Centre")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
            
            Button("Show Game Center") {
                isGameCenterPresented = true
            }
            
            Text("Tap to Dismiss")
                .padding()
                .onTapGesture {
                    isPresenting.toggle()
                }
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .ignoresSafeArea(edges: .all)
        
        .sheet(isPresented: $isGameCenterPresented) {
            GameCenterView(gameLogic: gameLogic)
        }
    }
}