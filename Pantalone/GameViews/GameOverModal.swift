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
    let pantalonePink = Color("PantalonePink")

    
    var body: some View {
        
        ZStack {
            Rectangle()
                .foregroundStyle(cream)
                .ignoresSafeArea()
            
            VStack {
                Text("Congratulations!")
                    .font(customTitle)
                    .foregroundColor(.black)
                    .bold()
                    .padding()
                
                Image(menuViewModel.selectedCardSet?.setImage ?? "card_back_bird")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(16)
                
                
                Text("You matched all the cards in \(gameLogic.turns) turns!")
                    .bold()
                    .foregroundColor(.black)
                    .padding(10)
                
                Text("Try to match the cards in less than 16 turns.")
                    .bold()
                    .foregroundColor(.black)
                    .padding(10)
                
                
//                HStack {
//                    Button("Admire your game!") {
//                        gameLogic.gameOverModalIsPresented = false
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .foregroundColor(colorScheme == .dark ? .black : .white)
//                    .padding()
//                    
//                    Button("Play a new game!") {
//                        gameLogic.gameOverModalIsPresented = false
//                        gameLogic.handleReset()
//                    }
//                    .buttonStyle(.borderedProminent)
//                    .foregroundColor(colorScheme == .dark ? .black : .white)
//                    .padding()
//                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        gameLogic.gameOverModalIsPresented = false
                    }) {
                        Text("Admire your game!")
                            .buttonStyle(.borderedProminent)
                            .foregroundColor(.black)
                            .frame(width: 132, height: 60)
                            .background(.pantalonePink)
                            .cornerRadius(30)
                            .padding()
                    }
                    
                    Button(action: {
                        gameLogic.gameOverModalIsPresented = false
                        gameLogic.handleReset()
                    }) {
                        Text("Play a new game!")
                            .buttonStyle(.borderedProminent)
                            .foregroundColor(.black)
                            .frame(width: 132, height: 60)
                            .background(.pantalonePink)
                            .cornerRadius(30)
                            .padding()
                    }
                }
            }
        }
    }
}

//#Preview {
//    GameOverModal(menuViewModel: menuViewModel, gameLogic: gameLogic)
//}
