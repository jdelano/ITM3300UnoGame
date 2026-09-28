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
        color == .wild ||
        other.color == .wild ||
        color == other.color ||
        type == other.type
    }
}

extension UnoCard: Comparable {
    static func < (lhs: UnoCard, rhs: UnoCard) -> Bool {
        if lhs.color.sortRank != rhs.color.sortRank {
            return lhs.color.sortRank < rhs.color.sortRank
        }
        return lhs.type.sortRank < rhs.type.sortRank
    }
}
