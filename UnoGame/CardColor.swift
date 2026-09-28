//
//  CardColor.swift
//  UnoGame
//
//  Created by John Delano on 9/14/26.
//

import Foundation

enum CardColor: CaseIterable {
    case red, yellow, green, blue, wild
}

extension CardColor: Comparable {
    var sortRank: Int {
        switch self {
            case .red: 0
            case .yellow: 1
            case .green: 2
            case .blue: 3
            case .wild: 4
        }
    }
}
