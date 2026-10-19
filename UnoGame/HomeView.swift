//
//  HomeView.swift
//  UnoGame
//
//  Created by John Delano on 10/19/26.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel = UnoGameViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Color.clear
                    .cardify(isFaceUp: false)
                    .frame(width: 180)
                NavigationLink("Play") {
                    ContentView(viewModel: viewModel)
                }
                NavigationLink("How to Play") {
                    RulesView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
