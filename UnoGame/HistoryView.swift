//
//  HistoryView.swift
//  UnoGame
//
//  Created by John Delano on 10/19/26.
//

import SwiftUI

struct HistoryView: View {
    let viewModel: UnoGameViewModel
    
    var body: some View {
        List(viewModel.discardPile.reversed()) { card in
            NavigationLink(value: card) {
                Text("\(card.color) \(card.type.symbol)")
            }
            
        }
        .navigationTitle("Played Cards")
        
    }
}

#Preview {
    HistoryView(viewModel: UnoGameViewModel())
}
