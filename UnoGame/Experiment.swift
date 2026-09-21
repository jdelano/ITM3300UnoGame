//
//  Experiment.swift
//  UnoGame
//
//  Created by John Delano on 9/21/26.
//

import Foundation

struct PlayerScore {
    var points: Int
    
    mutating func award(points amount: Int = 1) {
        points += amount
    }
    
}

class GameClock {
    var seconds = 0
}


func runExperiment() {
    var a = PlayerScore(points: 10)
    var b = a
    b.points = 100
    print("a: \(a.points), b: \(b.points)")
    
    let clockA = GameClock()
    let clockB = clockA
    clockB.seconds = 100
    print("clockA: \(clockA.seconds), clockB: \(clockB.seconds)")
    
    
//    a.award(points: 10)
}
