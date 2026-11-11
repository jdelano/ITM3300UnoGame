//
//  ScoresView.swift
//  UnoGame
//
//  Created by John Delano on 11/11/26.
//

import SwiftUI

struct ScoresView: View {
    @State private var viewModel = ScoresViewModel()
    
    var body: some View {
        Group {
            switch viewModel.state {
                case .loading:
                    ProgressView("Loading scores...")
                case .loaded(let entries):
                    ScoresList(entries: entries)
                case .failed(let message):
                    ContentUnavailableView {
                        Label("No Scores", systemImage: "wifi.slash")
                    } description: {
                        Text(message)
                    } actions: {
                        Button("Try Again") {
                            Task { await viewModel.loadScores() }
                        }
                    }
            }
        }
        .navigationTitle("High Scores")
        .task { await viewModel.loadScores() }
    }
}

struct ScoresList: View {
    let entries: [ScoreEntry]
    
    var body: some View {
        if entries.isEmpty {
            ContentUnavailableView("No scores yet", systemImage: "trophy")
        } else {
            List(Array(entries.enumerated()), id: \.offset) { index, entry in
                HStack {
                    Text("\(index + 1).")
                    Text(entry.playerName)
                    Spacer()
                    Text("\(entry.score)").bold()
                }
            }
        }
    }
}

#Preview {
    ScoresView()
}
