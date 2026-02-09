//
//  GameOverModal.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-09.
//

import SwiftUI

struct GameOverModal: View {
    
    var gameLogic = GameLogic()
    let customTitle = Font.custom("FrederickatheGreat-Regular", size: 32)
    
    
    var body: some View {
        
        Text("Congratulations!")
            .font(customTitle)
            .padding()
        
        Image("card_back_bird")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .cornerRadius(16)
        
        
        Text("You matched all the cards in \(gameLogic.turns) turns!")
            .padding(10)
        
        Text("Try to match the cards in less than 16 turns.")
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
    }
}

#Preview {
    GameOverModal()
}
