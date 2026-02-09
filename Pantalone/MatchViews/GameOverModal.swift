//
//  GameOverModal.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-02-09.
//

import SwiftUI

struct GameOverModal: View {
    
    @ObservedObject var menuViewModel: MenuViewModel
    
    var gameLogic = GameLogic()
    let customTitle = Font.custom("FrederickatheGreat-Regular", size: 32)
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
//                VStack{
//                    Image (systemName: "square.and.arrow.up.fill")
//                        .resizable()
//                        .foregroundStyle(.accent)
//                        .frame(width: 32, height: 40)
//                        .bold()
//                    
//                    Text("Share your score with your friends!")
//                        .bold()
//                        .padding(10)
//                }
//                .onTapGesture(gameLogic.gameOverModalIsPresented = false)
                // Add logic to capture ContentView and display shareImage: UIImage?
            }
        }
    }
}

//#Preview {
//    GameOverModal(menuViewModel: MenuViewModel(), )
//}
