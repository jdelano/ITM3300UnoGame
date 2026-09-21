//
//  UnoGameViewModel.swift
//  UnoGame
//
//  Created by John Delano on 9/14/26.
//

import SwiftUI

@Observable
class UnoGameViewModel {
    var cards: [UnoCard] = []
    private var deck: [UnoCard] = []
    var discardPile: [UnoCard] = []
    
    func newGame() {
        deck = []
        for color in [CardColor.red, .yellow, .green, .blue] {
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
        deal(7)
        if let card = deck.popLast() {
            discardPile.append(card)
        }

    }
    
    func deal(_ count: Int = 1) {
        for _ in 0..<count {
            if let card = deck.popLast() {
                cards.append(card)
            }
        }
    }
    
    func play(_ card: UnoCard) {
        
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
    

}

