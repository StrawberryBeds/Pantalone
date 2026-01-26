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
    
    @State private var isGameCenterPresented: Bool = false
    
    var body: some View {
        TabView {
            MenuView(gameLogic: gameLogic)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            Color.accentColor
                .onAppear {
                    isGameCenterPresented = true
                }
                .overlay(
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                )
                .tabItem {
                    Label("GameCentre", systemImage: "trophy.fill")
                }
                    }
                    .sheet(isPresented: $isGameCenterPresented) {
                        GameCenterView(gameLogic: gameLogic)
                    }
                }
            }

#Preview {
    MainTabView()
}
