//
//  ScoresViewModel.swift
//  UnoGame
//
//  Created by John Delano on 11/11/26.
//

import SwiftUI

@MainActor
@Observable
class ScoresViewModel {
    enum LoadState {
        case loading
        case loaded([ScoreEntry])
        case failed(String)
    }
    
    var state: LoadState = .loading
    
    private let scoresURL = URL(string:
                                    "https://gameapi.drjdelano.com/uno/scores?semesterTag=2026FA")!
    private let apiKey = "ce854fef1f7bf5eb1d43f8bec6735d7773caa68d1f7e0097353c46c78d2dc813"

    func startPolling() async {
        while !Task.isCancelled {
            print("Polling...")
            await loadScores()
            try? await Task.sleep(for: .seconds(5))
        }
        print("Polling stopped")
    }
    
    func loadScores() async {
        var request = URLRequest(url: scoresURL)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
                state = .failed("The server didn't send the scores. Try again later.")
                return
            }
            let entries = try JSONDecoder().decode([ScoreEntry].self, from: data)
            state = .loaded(entries)
        } catch {
            state = .failed("Couldn't reach the server. Check your connection.")
        }
    }
    
}
