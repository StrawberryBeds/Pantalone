//
//  TabView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-20.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var gameCenterManager: GameCenterManager
    @StateObject var gameLogic = MatchGameLogic()
//    @State private var isPresenting = false
    @State private var selectedCardSet: CardSet?

    var body: some View {
        TabView {
            MenuView(gameLogic: gameLogic)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            CustomLeaderboardView()
                .tabItem {
                    Label("Leaderboards", systemImage: "list.number")
                }
        }
    }
}
