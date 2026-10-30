//
//  RulesView.swift
//  UnoGame
//
//  Created by John Delano on 10/19/26.
//

import SwiftUI

struct RulesView: View {
    var body: some View {
        List {
            Text("Match the top card by color, number, or symbol.")
            Text("Wild cards can be played on anything.")
            Text("Skip, Reverse, and Draw Two change whose turn it is.")
            Text("Play your last card to win.")
        }
        .navigationTitle("How to Play")
    }
}

#Preview {
    NavigationStack {
        RulesView()
    }
}
