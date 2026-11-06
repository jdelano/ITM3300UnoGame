//
//  SavedGame.swift
//  UnoGame
//
//  Created by John Delano on 11/6/26.
//

import Foundation

struct SavedGame: Codable {
    var cards: [UnoCard]
    var discardPile: [UnoCard]
    var deck: [UnoCard]
    
}

