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


func fetchRawScores() async {
    let url = URL(string:
                    "https://gameapi.drjdelano.com/uno/scores?semesterTag=2026FA")!
    var request = URLRequest(url: url)
    request.setValue("ce854fef1f7bf5eb1d43f8bec6735d7773caa68d1f7e0097353c46c78d2dc813",
                     forHTTPHeaderField: "X-Api-Key")
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        print((response as? HTTPURLResponse)?.statusCode ?? 0)
        print(String(decoding: data, as: UTF8.self))
    } catch let err {
        print("Request failed: \(err)")
    }
    

}
