//
//  UnoCard.swift
//  UnoGame
//
//  Created by John Delano on 9/14/26.
//

import Foundation

struct UnoCard : Identifiable {
    let id: UUID = UUID()
    let type: CardType
    let color: CardColor
    
    func matches(_ other: UnoCard) -> Bool {
        color == .wild || other.color == .wild || color == other.color || type.symbol == other.type.symbol
    }
}
