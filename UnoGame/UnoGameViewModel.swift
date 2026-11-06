//
//  UnoGameViewModel.swift
//  UnoGame
//
//  Created by John Delano on 9/14/26.
//

import SwiftUI

@Observable
class UnoGameViewModel {
    static let saveURL = URL.documentsDirectory.appending(path: "uno-game.json")
    static let openingHandSize = 7
    var statusMessage: String? = nil
    var cardsRemaining: Int {
        deck.count
    }
    var cards: [UnoCard] = [] {
        didSet {
            if cards.isEmpty && !oldValue.isEmpty {
                statusMessage = "You played your whole hand!"
            }
        }
    }
    
    private(set) var deck: [UnoCard] = []
    var discardPile: [UnoCard] = []
    var gamesPlayed = UserDefaults.standard.integer(forKey: "gamesPlayed") {
        didSet {
            UserDefaults.standard.set(gamesPlayed, forKey: "gamesPlayed")
        }
    }
    
    init() {
        load()
    }
    
    
    
    
    func newGame() {
        gamesPlayed += 1
        deck = []
        for color in CardColor.allCases where color != .wild {
            deck.append(UnoCard(type: .number(0), color: color))
            for _ in 1...2 {
                for number in 1...9 {
                    deck.append(UnoCard(type: .number(number), color: color))
                }
                deck.append(UnoCard(type: .skip, color: color))
                deck.append(UnoCard(type: .reverse, color: color))
                deck.append(UnoCard(type: .drawTwo, color: color))
            }
        }
        for _ in 1...4 {
            deck.append(UnoCard(type: .wild, color: .wild))
            deck.append(UnoCard(type: .wildDrawFour, color: .wild))
        }
        deck.shuffle()
        cards = []
        discardPile = []
        deal(Self.openingHandSize)
        if let card = deck.popLast() {
            discardPile.append(card)
        }
        statusMessage = nil
        save()
    }
    
    func deal(_ count: Int = 1) {
        for _ in 0..<count {
            if let card = deck.popLast() {
                cards.append(card)
            }
        }
    }
    
    func canPlay(_ card: UnoCard) -> Bool {
        guard let top = discardPile.last else { return false }
        return card.matches(top) && card != top
    }
    
    func play(_ card: UnoCard) {
        guard canPlay(card), let index = cards.firstIndex(where: { $0.id == card.id }) else { return }
        cards.remove(at: index)
        discardPile.append(card)
        save()
    }
    
    func color(for card: UnoCard) -> Color {
        switch card.color {
            case .blue: return .blue
            case .green: return .green
            case .red: return .red
            case .yellow: return .yellow
            case .wild: return .black
        }
    }
    
    func sortHand() {
        cards.sort()
    }
    
    func save() {
        let game = SavedGame(cards: cards, discardPile: discardPile, deck: deck)
        do {
            let data = try JSONEncoder().encode(game)
            try data.write(to: Self.saveURL)
        } catch {
            print("Save failed: \(error)")
        }
    }
    
    func load() {
        do {
            let data = try Data(contentsOf: Self.saveURL)
            let game = try JSONDecoder().decode(SavedGame.self, from: data)
            cards = game.cards
            discardPile = game.discardPile
            deck = game.deck
        } catch {
            print("Failed to load game \(error)")
            newGame()
        }
    }
}

