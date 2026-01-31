//
//  TabView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-20.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var gameLogic = GameLogic()
//    @State private var isPresenting = false
    @State private var selectedCardSet: CardSet?

    var body: some View {
        TabView {
            MenuView(gameLogic: gameLogic)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            CustomLeaderboardView(gameLogic: gameLogic)
                .tabItem {
                    Label("Leaderboard", systemImage: "list.number")
                }
        }
    }
}

#Preview {
    MainTabView()
}
