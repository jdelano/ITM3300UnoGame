//
//  ContentView.swift
//  UnoGame
//
//  Created by John Delano on 8/19/26.
//


import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            HStack {
                UnoCardView(cardType: .wildDrawFour, color: .black)
                UnoCardView(cardType: .drawTwo, color: .yellow)

            }
            HStack {
                UnoCardView(cardType: .number(6), color: .green)
                UnoCardView(cardType: .skip, color: .blue)

            }
        }

    }
    

    
}

#Preview {
    ContentView()
}



