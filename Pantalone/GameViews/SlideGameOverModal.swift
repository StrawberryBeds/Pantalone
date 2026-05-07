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
    
    var gameLogic = MatchGameLogic()
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
                
                if let selectedImage = slideGameViewModel.selectedImage {
                    Image(selectedImage.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .cornerRadius(16)
                } else {
                    Image("card_back_bird") // fallback if nil
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .cornerRadius(16)
                        .foregroundColor(.gray)
                }
                
                
                Text("You completed the puzzle in \(slideGameViewModel.moveCount) moves!")
                    .bold()
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(10)
                
                
                
                Button(action: {
                    slideGameViewModel.slideGameOverModalIsPresented = false
                }) {
                    Text("Dismiss")
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

//#Preview {
//    GameOverModal(menuViewModel: menuViewModel, gameLogic: gameLogic)
//}

