//
//  ContentView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//

import SwiftUI
import SwiftData
import GameKit
import CoreTransferable

struct ContentView: View {
    
    @ObservedObject var gameLogic: GameLogic
    @ObservedObject var menuViewModel: MenuViewModel
    @State var selectedCardSet: CardSet?
    
//    @State private var shareImage: UIImage? = nil
//    @State private var showingShareSheet = false
    
    let cream = Color("Cream")
    
    var body: some View {
        ZStack {
            Color.cream
                .ignoresSafeArea()
            VStack {
                GameBoardView(gameLogic: gameLogic, menuViewModel: menuViewModel, selectedCardSet: selectedCardSet)
                    .frame(maxWidth: .infinity)
                
                
//                Button("Generate Image and Share") {
//                    // 1. Render the view to a UIImage
//                    print("Content View - Generating Image")
//                    if let uiImage = ImageRenderer(content: GameBoardView(gameLogic: gameLogic, menuViewModel: menuViewModel, selectedCardSet: selectedCardSet)).uiImage {
//                        shareImage = uiImage
//                        print("Image generated successfully. Image is \(String(describing: shareImage?.size))")
//                        showingShareSheet = true
//                    }
//                }
            }
            .sheet(isPresented: $gameLogic.gameOverModalIsPresented) {
                GameOverModal(menuViewModel: menuViewModel, gameLogic: gameLogic)
            }
//            .sheet(isPresented: $showingShareSheet, onDismiss: {
//                shareImage = nil // Clear the image after the sheet is dismissed
//            }) {
//                if let shareImage = shareImage {
//                    // 3. Present the system share sheet with the generated image
//                    ActivityViewController(activityItems: [shareImage])
//                }
//            }
        }
    }
}

// A UIViewControllerRepresentable to wrap UIActivityViewController (the share sheet)
//struct ActivityViewController: UIViewControllerRepresentable {
//    var activityItems: [Any]
//    var applicationActivities: [UIActivity]? = nil
//    
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
//        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
//        return controller
//    }
//    
//    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
//}


