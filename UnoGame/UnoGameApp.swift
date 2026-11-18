//
//  UnoGameApp.swift
//  UnoGame
//
//  Created by John Delano on 8/19/26.
//

import SwiftUI
import SwiftData

@main
struct UnoGameApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: GameRecord.self)
    }
}
