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
            
            Text("You matched all the cards in x turns")
            
            Text("Try to match the cards in less than 16 turns")
            
            
            HStack {
                Button("Admire your game!") {
                    // .dismiss()
                }
                .buttonStyle(.bordered)
                
                NavigationLink("Play a new game!", destination: MenuView(gameLogic: GameLogic()))
            }
    }
}

#Preview {
    GameOverModal()
}
