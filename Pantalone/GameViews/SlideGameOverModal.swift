//
//  SlideGameOverModal.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-03-01.
//


import SwiftUI

struct SlideGameOverModal: View {
    
//    @ObservedObject var slideMenuViewModel: SlideMenuViewModel
    @ObservedObject var slideGameViewModel: SlideGameViewModel
//    @ObservedObject var sharingViewModel: SharingViewModel
    
    var gameLogic = SlideGameLogic()
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
                
//                Image(slideMenuViewModel.selectedSlideImage?.imageName ?? "card_back_bird")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 150, height: 150)
//                    .cornerRadius(16)
//                
                
                Text("You completed the image in \(slideGameViewModel.moveCount) moves!")
                    .bold()
                    .foregroundColor(.black)
                    .padding(10)
                
//                if gameLogic.turns < 16 {
//                    Image(systemName: "trophy.fill")
//                        .padding(10)
//                        
//                    Text("Well done! That's the least turns possible!")
//                }
//                
//                else {
//                    
//                    Text("Try to match the cards in less than 16 turns to win a trophy.")
//                        .bold()
//                        .foregroundColor(.black)
//                        .multilineTextAlignment(.center)
//                        .padding(10)
//                }
                
                
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
                        slideGameViewModel.slideGameOverModalIsPresented = false
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
                        slideGameViewModel.slideGameOverModalIsPresented = false
//                        gameLogic.handleReset()
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
