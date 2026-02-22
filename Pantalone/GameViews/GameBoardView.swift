//
//  GameBoardView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-09.
//

import SwiftUI
import SwiftData
import GameKit
import CoreTransferable

struct GameBoardView: View {
    
    @ObservedObject var gameLogic: GameLogic
    @ObservedObject var menuViewModel: MenuViewModel
    @State var selectedCardSet: CardSet?
    
//    @State private var shareImage: UIImage? = nil
//    @State private var showingShareSheet = false
    
    let cream = Color("Cream")
    let offWhite = Color("OffWhite")
    let customHeadline = Font.custom("FrederickatheGreat-Regular", size: 28)
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    var body: some View {
        VStack {
            HStack {
                Text("Turns: \(gameLogic.turns) Matches: \(gameLogic.matches)")
                    .font(customHeadline)
                    .foregroundColor(.black)
            }
            
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
        }
        .frame(maxWidth: .infinity)
    }
}


