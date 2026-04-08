//
//  MenuView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//

import SwiftUI
import GameKit
import Combine

struct MenuView: View {
    @StateObject var viewModel: MenuViewModel
    
    let customTitle = Font.custom("FrederickatheGreat-Regular", size: 36)
    let cream = Color("Cream")
    let pantalonePink = Color("PantalonePink")
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
    ]
    
    init(gameLogic: MatchGameLogic) {
        _viewModel = StateObject(wrappedValue: MenuViewModel(gameLogic: gameLogic))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                MatchMenuView(viewModel: viewModel, customTitle: customTitle, columns: columns)
                
                // Pass the first available cardSet (or selectedCardSet if one is selected)
                if let cardSet = viewModel.selectedCardSet ?? viewModel.cardSets.first {
                    SlideMenuView(cardSet: cardSet)
                }
            }
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.pantalonePink)
            .ignoresSafeArea(edges: .all)
        }
    }
}

