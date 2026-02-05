//
//  LeaderboardDetailView.swift
//  Pantalone
//
//  Created by Samuel Wood on 2026-01-31.
//

import SwiftUI
import GameKit
import Combine

struct LeaderboardDetailView: View {
    @StateObject var viewModel: LeaderboardDetailViewModel
    
    init(leaderboardID: String, leaderboardName: String) {
        _viewModel = StateObject(wrappedValue: LeaderboardDetailViewModel(leaderboardID: leaderboardID, leaderboardName: leaderboardName))
    }
    
    let customTitle = Font.custom("FrederickatheGreat-Regular", size: 32)
    let customHeadline = Font.custom("FrederickatheGreat-Regular", size: 24)
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else if let error = viewModel.loadError {
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    Text(error)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
            } else if viewModel.leaderboardEntries.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "trophy")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("No scores yet")
                        .foregroundColor(.secondary)
                    Text("Be the first to play!")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
            } else {
                Text("\(viewModel.leaderboardTitle.isEmpty ? viewModel.leaderboardName : viewModel.leaderboardTitle)")
                    .font(customTitle)
                    .padding()
                
                List {
                    ForEach(viewModel.leaderboardEntries) { entry in
                        HStack {
                            // Rank badge
                            Text("#\(entry.rank)")
                                .font(customHeadline)
                                .foregroundColor(.secondary)
                                .frame(width: 50, alignment: .leading)
                            
                            // Player name
                            Text(entry.playerName)
                                .lineLimit(1)
                                .font(customHeadline)
                            
                            Spacer()
                            
                            // Score
                            Text("\(entry.score)")
                                .font(customHeadline)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(.plain)
            }
        }
//        .navigationTitle(viewModel.leaderboardTitle.isEmpty ? viewModel.leaderboardName : viewModel.leaderboardTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if viewModel.leaderboardEntries.isEmpty {
                viewModel.loadLeaderboard()
            }
        }
    }
}
