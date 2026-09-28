//
//  CardType.swift
//  UnoGame
//
//  Created by John Delano on 9/9/26.
//

import Foundation

enum CardType: Equatable {
    case number(Int), skip, reverse, drawTwo, wild, wildDrawFour
    
    var symbol: String {
        switch self {
            case .skip:
                return "⊘"
            case .reverse:
                return "↺"
            case .drawTwo:
                return "+2"
            case .wild:
                return "W"
            case .wildDrawFour:
                return "+4"
            case .number(let cardNumber):
                return String("\(cardNumber)")
        }
    }
}

extension CardType: Comparable {
    var sortRank: Int {
        switch self {
            case .number (let value): value
            case .skip: 10
            case .reverse: 11
            case .drawTwo: 12
            case .wild: 13
            case .wildDrawFour: 14
        }
    }
}
