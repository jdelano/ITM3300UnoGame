//
//  ContentView.swift
//  UnoGame
//
//  Created by John Delano on 8/19/26.
//


import SwiftUI

struct ContentView: View {
    @State var viewModel = UnoGameViewModel()
    @Namespace private var cardNameSpace
    @State private var waitingToDeal: [UnoCard] = []
    
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                    ForEach(viewModel.cards) { card in
                        UnoCardView(card: card, viewModel: viewModel)
                            .matchedGeometryEffect(id: card.id, in: cardNameSpace)
                            .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
                    }
                }
            }
            HStack {
                Button("New Game") {
                    withAnimation(.bouncy(extraBounce: 0.1)) {
                        viewModel.newGame()
                        waitingToDeal = viewModel.cards
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
            HStack {
                ZStack {
                    ForEach(viewModel.deck) { card in
                        Color.clear
                            .cardify(isFaceUp: false)
                            .matchedGeometryEffect(id: card.id, in: cardNameSpace)
                            .transition(.asymmetric(insertion: .opacity, removal: .identity))
                            .frame(height: 200)
                            .id(card.id)
                    }
                }
                if let topCard = viewModel.discardPile.last {
                    UnoCardView(card: topCard, viewModel: viewModel)
                        .matchedGeometryEffect(id: topCard.id, in: cardNameSpace)
                        .id(topCard.id)
                        .frame(height: 200)
                }
            }
            
        }
        
    }
    
    
    
}

#Preview {
    ContentView()
}



