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
            }
            .navigationTitle("Uno")
            .navigationDestination(for: Route.self) { route in
                switch route {
                    case .game: ContentView(viewModel: viewModel)
                    case .history: HistoryView(viewModel: viewModel)
                }
            }
        }
        
    }
}

#Preview {
    HomeView()
}
