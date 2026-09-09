//
//  CardType.swift
//  UnoGame
//
//  Created by John Delano on 9/9/26.
//

import Foundation

enum CardType {
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
