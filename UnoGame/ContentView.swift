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
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                    ForEach(viewModel.cards) { card in
                        UnoCardView(card: card, viewModel: viewModel)
                    }
                }
            }
            HStack {
                Button("New Game") {
                    withAnimation(.bouncy(extraBounce: 0.1)) {
                        viewModel.newGame()
                    }
                }
                Button("Deal") {
                    withAnimation {
                        viewModel.deal()
                    }
                }
                Button("Sort") {
                    withAnimation {
                        viewModel.sortHand()
                    }
                }
                
            }
            .font(.title2)
            .buttonStyle(.borderedProminent)
            Text("Deck: \(viewModel.cardsRemaining) cards")
                .font(.headline)
            if let message = viewModel.statusMessage {
                Text(message)
                    .font(.title2)
                    .bold()
            }
            if let topCard = viewModel.discardPile.last {
                Text("Discard Pile")
                    .font(.headline)
                UnoCardView(card: topCard, viewModel: viewModel)
            }
        }

    }
    

    
}

#Preview {
    ContentView()
}



