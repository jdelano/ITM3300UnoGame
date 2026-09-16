//
//  UnoGameViewModel.swift
//  UnoGame
//
//  Created by John Delano on 9/14/26.
//

import SwiftUI

class UnoGameViewModel {
    var cards: [UnoCard] = [
        UnoCard(type: .wildDrawFour, color: .wild),
        UnoCard(type: .drawTwo, color: .yellow),
        UnoCard(type: .number(6), color: .green),
        UnoCard(type: .skip, color: .blue)
    ]
    
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

