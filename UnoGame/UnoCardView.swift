//
//  UnoCardView.swift
//  UnoGame
//
//  Created by John Delano on 8/31/26.
//

import SwiftUI

struct UnoCardView: View {
    let card: UnoCard
    let viewModel: UnoGameViewModel
    
    private var symbol: String {
        card.type.symbol
    }
    
    private var color: Color {
        viewModel.color(for: card)
    }
    
    var body: some View {
        cardFront
            .cardify(isFaceUp: true)
            .onTapGesture {
                viewModel.play(card)
            }
    }
    
    @ViewBuilder
    private var cardFront: some View {
        // Card front (blue 7)
        cardChrome(color: color, ellipseColor: .white)
        
        cardSymbol(color: color, size: 100)
        
        cornerSymbols
    }
    
    private func cardChrome(color: Color, ellipseColor: Color) -> some View {
        ZStack {
            // Black inner background, inset from the border
            RoundedRectangle(cornerRadius: 15)
                .sunburst(color: color)
//                .foregroundStyle(sunburstGradient(main: color, accent: color.opacity(0.75)))
                .padding(10)
            
            // Red tilted ellipse in the center
            Ellipse()
                .fill(ellipseColor)
                .rotationEffect(.degrees(45))
                .frame(width: 150, height: 200)
        }
    }
    
    private var cornerSymbols: some View {
        VStack {
            HStack {
                cardSymbol(color: .white, size: 30)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                cardSymbol(color: .white, size: 30)
                    .rotationEffect(.degrees(180))
            }
        }
        .padding(20)
    }
    
    
    private func cardSymbol(color: Color, size: CGFloat) -> some View {
        Text(symbol)
            .font(.system(size: size))
            .bold()
            .underline(symbol == "6" || symbol == "9", color: color)
            .foregroundStyle(color)
    }
}

#Preview {
    UnoCardView(card: UnoCard(type: .drawTwo, color: .green), viewModel: UnoGameViewModel())
}
