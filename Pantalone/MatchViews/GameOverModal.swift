//
//  GameOverModal.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-09.
//

import SwiftUI

struct GameOverModal: View {
    
    @ObservedObject var menuViewModel: MenuViewModel
//    @ObservedObject var sharingViewModel: SharingViewModel
    
    var gameLogic = GameLogic()
    let customTitle = Font.custom("FrederickatheGreat-Regular", size: 36)
    let cream = Color("Cream")

    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundStyle(cream)
                .ignoresSafeArea()
            
            VStack {
                Text("Congratulations!")
                    .font(customTitle)
                    .bold()
                    .padding()
                
                Image(menuViewModel.selectedCardSet?.setImage ?? "card_back_bird")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(16)
                
                
                Text("You matched all the cards in \(gameLogic.turns) turns!")
                    .bold()
                    .padding(10)
                
                Text("Try to match the cards in less than 16 turns.")
                    .bold()
                    .padding(10)
                
                
                HStack {
                    Button("Admire your game!") {
                        gameLogic.gameOverModalIsPresented = false
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.primary)
                    .padding()
                    
                    Button("Play a new game!") {
                        gameLogic.gameOverModalIsPresented = false
                        gameLogic.handleReset()
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.primary)
                    .padding()
                }
                
//                Button("Share your score with your friends!", systemImage: "square.and.arrow.up.fill") {
//                    gameLogic.gameOverModalIsPresented = false
//                }
            }
        }
    }
}

//#Preview {
//    GameOverModal(menuViewModel: MenuViewModel(), )
//}
