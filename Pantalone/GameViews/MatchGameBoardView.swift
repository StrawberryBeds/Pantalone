//
//  MatchGameBoardView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-09.
//

import SwiftUI
import SwiftData
import GameKit
import CoreTransferable

struct MatchGameBoardView: View {
    @ObservedObject var gameLogic: MatchGameLogic
    @ObservedObject var menuViewModel: MenuViewModel
    @State var selectedCardSet: CardSet?
    @Environment(\.horizontalSizeClass) var sizeClass

    let cream = Color("Cream")
    let customHeadline = Font.custom("FrederickatheGreat-Regular", size: 28)

    var cardSize: CGFloat {
        sizeClass == .regular ? 90 : 80  // iPad vs iPhone
    }

    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        VStack(spacing: 10) {
            Text("Turns: \(gameLogic.turns) Matches: \(gameLogic.matches)")
                .font(customHeadline)
                .foregroundColor(.black)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(gameLogic.cards) { card in
                    let isFlipped = gameLogic.flippedIndices.contains(card.id) || gameLogic.solvedIndices.contains(card.id)
                    let cardImage = isFlipped ? card.image : "card_back_bird"

                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.cream)
                            .frame(width: cardSize, height: cardSize)
                            .cornerRadius(8)
                        Image(cardImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: cardSize, height: cardSize)
                            .cornerRadius(8)
                            .onTapGesture { gameLogic.handleCardClick(card.id) }
                    }
                }
            }
            .frame(maxWidth: 500)        // cap grid width on iPad
            .frame(maxWidth: .infinity)  // centre it
        }
    }
}

