//
//  CustomLeaderboardView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-27.
//

import SwiftUI
import GameKit
import Combine

struct CustomLeaderboardView: View {
    @ObservedObject var gameLogic: GameLogic
    @StateObject var viewModel: CustomLeaderboardViewModel
    
    init(gameLogic: GameLogic) {
        self.gameLogic = gameLogic
        _viewModel = StateObject(wrappedValue: CustomLeaderboardViewModel(cardSets: CardDataSource.cardSets))
    }
    
    let customTitle = Font.custom("FrederickatheGreat-Regular", size: 32)
    let customHeadline = Font.custom("FrederickatheGreat-Regular", size: 24)
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            
            NavigationStack {
                Text("Leaderboards")
                    .font(customTitle)
                    .padding()
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Loading leaderboards...")
                            .padding()
                    } else if let error = viewModel.loadError {
                        VStack(spacing: 16) {
                            Image(systemName: "exclamationmark.triangle")
                                .font(.largeTitle)
                                .foregroundColor(.orange)
                            Text(error)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                            Button("Retry") {
                                viewModel.loadAvailableLeaderboards()
                            }
                            .buttonStyle(.bordered)
                        }
                        .padding()
                    } else if viewModel.availableLeaderboards.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "list.bullet.clipboard")
                                .font(.largeTitle)
                                .foregroundColor(.secondary)
                            Text("No leaderboards available")
                                .foregroundColor(.secondary)
                        }
                        .padding()
                    } else {
                        List(viewModel.availableLeaderboards) { leaderboard in
                            NavigationLink(destination: LeaderboardDetailView(
                                leaderboardID: leaderboard.id,
                                leaderboardName: leaderboard.name,
                                setImage: leaderboard.setImage
                            )) {
                                HStack {
                                    // Display Game Center image or fallback to icon
                                    if !leaderboard.setImage.isEmpty {
                                        Image(leaderboard.setImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                            .cornerRadius(8)
                                    } else {
                                        Image(systemName: "trophy")
                                            .font(.title2)
                                            .foregroundColor(.blue)
                                            .frame(width: 40, height: 40)
                                    }
                                    
                                    Text(leaderboard.name)
                                        .font(customHeadline)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .listStyle(.insetGrouped)
                    }
                }
                .onAppear {
                    if viewModel.availableLeaderboards.isEmpty {
                        viewModel.loadAvailableLeaderboards()
                    }
                }
            }
            .background(Color.clear) // Make NavigationStack transparent
            .scrollContentBackground(.hidden) // iOS 16+: Hide default background for scrollable content
        }
    }
}

