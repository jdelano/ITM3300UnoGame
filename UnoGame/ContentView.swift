//
//  ContentView.swift
//  UnoGame
//
//  Created by John Delano on 8/19/26.
//


import SwiftUI

struct ContentView: View {
    let viewModel: UnoGameViewModel
    @Namespace private var cardNameSpace
    @State private var waitingToDeal: [UnoCard] = []
    @State private var isHandHidden = false
    @State private var showingRules = false
    @AppStorage("showsHints") private var showsHints = true
    @State private var showingSettings = false
    
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                    ForEach(viewModel.cards) { card in
                        if !waitingToDeal.contains(card) {
                            UnoCardView(card: card, viewModel: viewModel, isFaceUp: !isHandHidden, showsHint: showsHints)
                                .matchedGeometryEffect(id: card.id, in: cardNameSpace)
                                .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
                                .draggable(card.id.uuidString)
                        }
                    }
                }
            }
            HStack {
                Button("New Game") {
                    withAnimation(.bouncy(extraBounce: 0.1)) {
                        viewModel.newGame()
                        waitingToDeal = viewModel.cards
                    }
                    for index in viewModel.cards.indices {
                        withAnimation(.easeInOut.delay(0.5 + 0.4 * Double(index))) {
                            _ = waitingToDeal.removeFirst()
                        }
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
                Button(isHandHidden ? "Show" : "Hide") {
                    withAnimation(.easeInOut(duration: 6)) {
                        isHandHidden.toggle()
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
                    ForEach(viewModel.deck + waitingToDeal.reversed()) { card in
                        Color.clear
                            .cardify(isFaceUp: false)
                            .matchedGeometryEffect(id: card.id, in: cardNameSpace)
                            .transition(.asymmetric(insertion: .opacity, removal: .identity))
                            .frame(height: 200)
                            .id(card.id)
                    }
                }
                if let topCard = viewModel.discardPile.last {
                    UnoCardView(card: topCard, viewModel: viewModel, showsHint: showsHints)
                        .matchedGeometryEffect(id: topCard.id, in: cardNameSpace)
                        .id(topCard.id)
                        .frame(height: 200)
                        .dropDestination(for: String.self) { ids, _ in
                            guard let id = ids.first, let card = viewModel.cards.first(where: { $0.id.uuidString == id }),
                                  viewModel.canPlay(card) else {
                                return false
                            }
                            withAnimation {
                                viewModel.play(card)
                            }
                            return true
                        }
                }
            }
            
        }
        .toolbar {
            NavigationLink("History") {
                HistoryView(viewModel: viewModel)
            }
            Button("Rules") {
                showingRules = true
            }
            Button("Settings", systemImage: "gearshape") {
                showingSettings = true
            }
        }
        .sheet(isPresented: $showingRules) {
            RulesView()
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView(showsHints: $showsHints)
                .presentationDetents([.medium])
        }
        
    }
    
    
    
}

#Preview {
    NavigationStack {
        ContentView(viewModel: UnoGameViewModel())
    }
}



