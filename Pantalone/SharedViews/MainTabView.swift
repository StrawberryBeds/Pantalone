//
//  TabView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-20.
//

import SwiftUI

struct MainTabView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var selection: String? = "home"
    @EnvironmentObject var gameCenterManager: GameCenterManager
    @StateObject var gameLogic = MatchGameLogic()
//    @State private var isPresenting = false
    @State private var selectedCardSet: CardSet?

    var body: some View {
        if sizeClass == .regular {
            // iPad: sidebar layout
            NavigationSplitView {
                List(selection: $selection) {
                    Label("Home", systemImage: "house.fill").tag("home")
                    Label("Leaderboards", systemImage: "list.number").tag("leaderboards")
                }
                .navigationTitle("Pantalone")
            } detail: {
                switch selection {
                case "leaderboards": CustomLeaderboardView()
                default: MenuView(gameLogic: gameLogic)
                }
            }
        } else {
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
}
