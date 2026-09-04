//
//  CardifyModifier.swift
//  UnoGame
//
//  Created by John Delano on 9/2/26.
//

import SwiftUI

struct CardifyModifier: ViewModifier {
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            // White outer card with black border
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .strokeBorder(.black)
            if isFaceUp {
                content
            } else {
                cardBack()
            }
        }
        .frame(width: 200, height: 300)
    }
    
    @ViewBuilder
    private func cardBack() -> some View {
        // Black inner background, inset from the border
        RoundedRectangle(cornerRadius: 15)
            .padding(10)
        
        // Red tilted ellipse in the center
        Ellipse()
            .sunburst(color: .red, accent: .red.opacity(0.9))
            .rotationEffect(.degrees(45))
            .frame(width: 150, height: 200)
        
        // UNO logo with gradient, tilted, with shadow
        Text("UNO")
            .font(.system(size: 60))
            .bold()
            .fixedSize()
            .foregroundStyle(
                LinearGradient(
                    colors: [.white, .yellow],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .rotationEffect(.degrees(-10))
            .shadow(color: .black, radius: 5, x: -3, y: 5)
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(CardifyModifier(isFaceUp: isFaceUp))
    }
}
