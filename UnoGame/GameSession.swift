//
//  GameSession.swift
//  UnoGame
//
//  Created by John Delano on 11/16/26.
//

import Foundation

struct GameSession: Codable {
    let id: String              // the 4-letter game code
    let status: String          // waiting, active, finished
    let version: Int            // goes up on every change
    let topCard: ServerCard?
    let activeColor: String?    // the color to match (wilds change it)
    let lastMove: LastMove?
    let you: Player?            // only sent with your player token
}

struct ServerCard: Codable, Identifiable {    // the server's card, not our UnoCard
    let id: String
    let color: String           // "red", "yellow", "green", "blue", or "wild"
    let type: String            // "number", "skip", "reverse", "drawTwo", "wild", "wildDrawFour"
    let value: Int?
    
    var name: String {          // "red 7", "blue skip"
        if type == "number" { return "\(color) \(value ?? 0)" }
        if type == "wild" { return "wild" }
        if type == "wildDrawFour" { return "wild draw four" }
        return "\(color) \(type)"
    }
}

struct LastMove: Codable { let summary: String }

struct Player: Codable {
    let hand: [ServerCard]
    let legalMoves: [Move]      // empty unless it's your turn
}

struct Move: Codable, Hashable {
    let type: String            // "play", "draw", or "pass"
    let cardId: String?
    let color: String?          // the color a wild will become
}

// Request bodies we send
struct NewGame: Encodable {
    let semesterTag: String
    let playerName: String
    let maxPlayers: Int
    let bots: Int
}

struct Joined: Codable {
    let playerToken: String
    let session: GameSession
}

struct MoveRequest: Encodable {
    let type: String
    let cardId: String?
    let color: String?
    let expectedVersion: Int
}
