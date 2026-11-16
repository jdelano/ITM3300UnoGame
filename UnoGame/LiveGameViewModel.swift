//
//  LiveGameViewModel.swift
//  UnoGame
//
//  Created by John Delano on 11/16/26.
//

import SwiftUI

@MainActor
@Observable
class LiveGameViewModel {
    var session: GameSession?
    private var token = ""
    private let base = URL(string: "https://gameapi.drjdelano.com")!
    private let apiKey = "ce854fef1f7bf5eb1d43f8bec6735d7773caa68d1f7e0097353c46c78d2dc813"

    var isMyTurn: Bool {
        !(session?.you?.legalMoves.isEmpty ?? true)
    }
    
    func color(for name: String?) -> Color {
        switch name {
            case "red": .red
            case "yellow": .yellow
            case "green": .green
            case "blue": .blue
            case "wild": .black
            default: .gray
        }
    }
    
    func isPlayable(_ card: ServerCard) -> Bool {
        session?.you?.legalMoves.contains { $0.cardId == card.id } ?? false
    }
    
    func playMove(for card: ServerCard) -> Move? {
        session?.you?.legalMoves.first { $0.cardId == card.id && $0.color == nil }
    }
    
    func colorChoices(for card: ServerCard) -> [Move] {
        session?.you?.legalMoves.filter { $0.cardId == card.id } ?? []
    }
    
    func run(playerName: String) async {
        await startGame(playerName: playerName)
        while !Task.isCancelled && session?.status != "finished" {
            if !isMyTurn, let latest = await fetchSession() {
                session = latest
            }
            try? await Task.sleep(for: .seconds(2))
        }
    }
    
    
    func startGame(playerName: String) async {
        let created: Joined? = await post("uno/sessions",
                                          body: NewGame(semesterTag: "2026FA", playerName: playerName,
                                                        maxPlayers: 3, bots: 2))
        guard let created else { return }
        token = created.playerToken
        session = await post("uno/sessions/\(created.session.id)/start",
                             body: [String: String]())
    }
    
    func play(_ move: Move) async {
        guard let session else { return }
        let body = MoveRequest(type: move.type, cardId: move.cardId,
                               color: move.color,
                               expectedVersion: session.version)
        if let updated: GameSession = await post(
            "uno/sessions/\(session.id)/moves", body: body) {
            self.session = updated
        }
    }
    
    private func fetchSession() async -> GameSession? {
        guard let session else { return nil }
        let url = base.appending(path: "uno/sessions/\(session.id)")
            .appending(queryItems: [URLQueryItem(name: "sinceVersion",
                                                 value: "\(session.version)")])
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        request.setValue(token, forHTTPHeaderField: "X-Player-Token")
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return nil      // 304: nothing new
            }
            return try JSONDecoder().decode(GameSession.self, from: data)
        } catch {
            return nil          // a failed poll: keep what we have
        }
    }
    
    private func post<Response: Decodable>(_ path: String,
                                           body: some Encodable) async -> Response? {
        var request = URLRequest(url: base.appending(path: path))
        request.httpMethod = "POST"
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
        request.setValue(token, forHTTPHeaderField: "X-Player-Token")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let http = response as? HTTPURLResponse,
                  (200...201).contains(http.statusCode) else {
                return nil
            }
            return try JSONDecoder().decode(Response.self, from: data)
        } catch {
            return nil
        }
    }
}

