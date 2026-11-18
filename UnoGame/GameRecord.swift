//
//  GameRecord.swift
//  UnoGame
//
//  Created by John Delano on 11/18/26.
//

import Foundation
import SwiftData

@Model
class GameRecord {
    var date: Date
    var cardsPlayed: Int
    var cardsLeft: Int
    
    init(cardsPlayed: Int, cardsLeft: Int) {
        self.date = .now
        self.cardsPlayed = cardsPlayed
        self.cardsLeft = cardsLeft
    }
}
