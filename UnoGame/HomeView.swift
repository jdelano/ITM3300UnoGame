//
//  HomeView.swift
//  UnoGame
//
//  Created by John Delano on 10/19/26.
//

import SwiftUI

enum Route: Hashable {
    case game, history
}


struct HomeView: View {
    @State var viewModel = UnoGameViewModel()
    @AppStorage("playerName") private var playerName = "Player 1"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Color.clear
                    .cardify(isFaceUp: false)
                    .frame(width: 180)
                NavigationLink("Play", value: Route.game)
                NavigationLink("How to Play") {
                    RulesView()
                }
                Text(playerName == "Player 1" ? " Welcome!" : "Welcome back, \(playerName)!")
                Text("Games played: \(viewModel.gamesPlayed)")
                    .font(.headline)
            }
            .navigationTitle("Uno")
            .navigationDestination(for: Route.self) { route in
                switch route {
                    case .game: ContentView(viewModel: viewModel)
                    case .history: HistoryView(viewModel: viewModel)
                }
            }
        }
//        .onAppear {
//            runExperiments()
//        }
        
    }
}

#Preview {
    HomeView()
}
