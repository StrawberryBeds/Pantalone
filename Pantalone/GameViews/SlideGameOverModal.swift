//
//  SlideGameOverModal.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-03-01.
//

import SwiftUI

struct SlideGameOverModal: View {
    
    @Environment(\.dismiss) var dismiss // 1. Access dismiss
    @ObservedObject var slideGameViewModel: SlideGameViewModel
//    @ObservedObject var sharingViewModel: SharingViewModel
    
    var gameLogic = GameLogic()
    var slideGameLogic = SlideGameLogic()
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
                
//                Image("\(slideGameViewModel.selectedImage)")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 150, height: 150)
//                    .cornerRadius(16)
                
                
                Text("You completed the \(slideGameViewModel.selectedImage?.cardName ?? "Unknown Card") puzzle in \(slideGameViewModel.moveCount) moves!")
                    .bold()
                    .foregroundColor(.black)
                    .padding(10)
                
                
                NavigationStack {
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
                        
                        NavigationLink(
                            destination: {
                                MenuView(gameLogic: gameLogic)
                            },
                            label: {
                                Text("Play a new puzzle!")
                                    .buttonStyle(.borderedProminent)
                                    .foregroundColor(.black)
                                    .frame(width: 132, height: 60)
                                    .background(.pantalonePink)
                                    .cornerRadius(30)
                                    .padding()
                            }
                        )
                        .onTapGesture {
                            slideGameViewModel.slideGameOverModalIsPresented = false
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    GameOverModal(menuViewModel: menuViewModel, gameLogic: gameLogic)
//}

