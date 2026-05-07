//
//  PantaloneApp.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-16.
//

import SwiftUI
import SwiftData
import GameKit

@main
struct PantaloneApp: App {
    
    @StateObject private var gameCenterManager = GameCenterManager()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .onAppear(perform: gameCenterManager.authenticateUser)
                .environmentObject(gameCenterManager)
        }
    }
}
