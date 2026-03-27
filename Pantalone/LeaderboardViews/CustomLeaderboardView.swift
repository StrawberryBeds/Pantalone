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
    @ObservedObject var gameLogic: MatchGameLogic
    @StateObject var viewModel: CustomLeaderboardViewModel
    
    init(gameLogic: MatchGameLogic) {
        self.gameLogic = gameLogic
        _viewModel = StateObject(wrappedValue: CustomLeaderboardViewModel(cardSets: CardDataSource.cardSets))
    }
    
    let customTitle = Font.custom("FrederickatheGreat-Regular", size: 36)
    let customHeadline = Font.custom("FrederickatheGreat-Regular", size: 24)
    let cream = Color("Cream")
    
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
                        let groupedLeaderboards = Dictionary(grouping: viewModel.availableLeaderboards, by: { $0.gameType })
                        
                        List {
                            ForEach(groupedLeaderboards.keys.sorted(), id: \.self) { gameType in
                                if let leaderboards = groupedLeaderboards[gameType] {
                                    Section(header: Text(gameType.capitalized)) {
                                        ForEach(leaderboards) { leaderboard in
                                            NavigationLink(destination: LeaderboardDetailView(
                                                leaderboardID: leaderboard.id,
                                                leaderboardName: leaderboard.name,
                                                cardImage: leaderboard.cardImage
                                            )) {
                                                HStack {
                                                    Image(leaderboard.cardImage)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 40, height: 40)
                                                        .cornerRadius(8)
                                                    Text(leaderboard.name)
                                                        .font(customHeadline)
                                                        .foregroundColor(.primary)
                                                }
                                                .padding()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    if viewModel.availableLeaderboards.isEmpty {
                        viewModel.loadAvailableLeaderboards()
                    }
                }
            }
            .background(.cream)
            .scrollContentBackground(.hidden)
        }
    }
}
