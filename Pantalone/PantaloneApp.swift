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
    
    @ObservedObject var gameLogic = GameLogic()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: gameLogic.authenticateUser)
        }
    }

}
