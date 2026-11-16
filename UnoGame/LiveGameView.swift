//
//  LiveGameView.swift
//  UnoGame
//
//  Created by John Delano on 11/16/26.
//

import SwiftUI

struct LiveGameView: View {
    @State private var viewModel = LiveGameViewModel()
    @AppStorage("playerName") private var playerName = "Player"
    @State private var wildToPlay: ServerCard?
    @State private var choosingColor = false
    
    var body: some View {
        VStack(spacing: 20) {
            if let session = viewModel.session {
                Text(session.topCard?.name ?? "-")
                    .font(.largeTitle).bold()
                    .foregroundStyle(viewModel.color(for: session.activeColor))
                Text(session.lastMove?.summary ?? "Your move")
                moves(for: session)
            } else {
                ProgressView("Starting a game...")
            }
        }
        .navigationTitle("Live Uno")
        .confirmationDialog("Choose a color", isPresented: $choosingColor,
                            presenting: wildToPlay) { card in
            ForEach(viewModel.colorChoices(for: card), id: \.self) { move in
                Button(move.color?.capitalized ?? "") {
                    Task { await viewModel.play(move) }
                }
            }
        }
                            .task { await viewModel.run(playerName: playerName) }
    }
    
    @ViewBuilder
    private func moves(for session: GameSession) -> some View {
        if let you = session.you {
            hand(you)
        }
        if viewModel.isMyTurn {
            ForEach(session.you?.legalMoves.filter { $0.cardId == nil } ?? [], id: \.self) { move in
                Button(move.type == "draw" ? "Draw a card" : "Pass") {
                    Task { await viewModel.play(move) }
                }
                .buttonStyle(.bordered)
            }
        } else {
            ProgressView("Waiting for the other players...")
        }
    }
    
    private func hand(_ you: Player) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 110))]) {
            ForEach(you.hand) { card in
                Button(card.name) { tap(card) }
                    .buttonStyle(.borderedProminent)
                    .tint(viewModel.color(for: card.color))
                    .opacity(viewModel.isPlayable(card) ? 1 : 0.4)
            }
        }
        .padding()
    }
    
    private func tap(_ card: ServerCard) {
        if let move = viewModel.playMove(for: card) {
            Task { await viewModel.play(move) }
        } else if !viewModel.colorChoices(for: card).isEmpty {
            wildToPlay = card                     // ask for the color first
            choosingColor = true
        }
    }
}

#Preview {
    LiveGameView()
}
