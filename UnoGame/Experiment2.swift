//
//  Experiment2.swift
//  UnoGame
//
//  Created by John Delano on 11/4/26.
//

import Foundation

func runExperiments() {
    let card = UnoCard(type: .number(7), color: .red)
    do {
        let data = try JSONEncoder().encode(card)
        print(String(decoding: data, as: UTF8.self))
        
        let copy = try JSONDecoder().decode(UnoCard.self, from: data)
        print(copy == card)
    } catch {
        print("Something went wrong: \(error)")
    }
    
    let bad = Data("this is not JSON".utf8)
    do {
        let card = try JSONDecoder().decode(UnoCard.self, from: bad)
        print(card)
    } catch {
        print("Couldn't decode: \(error)")
    }
}
