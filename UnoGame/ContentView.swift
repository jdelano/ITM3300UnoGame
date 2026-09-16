//
//  ContentView.swift
//  UnoGame
//
//  Created by John Delano on 8/19/26.
//


import SwiftUI

struct ContentView: View {
    let viewModel = UnoGameViewModel()
    var body: some View {
        VStack {
            HStack {
                ForEach(viewModel.cards) { card in
                    UnoCardView(card: card, viewModel: viewModel)
                }
            }
            HStack {
                Button("New Game") {
                    viewModel.newGame()
                }
                Button("Deal") {
                    viewModel.deal()
                }
                
            }
            .font(.title2)
            .buttonStyle(.borderedProminent)
        }

    }
    

    
}

#Preview {
    ContentView()
}



