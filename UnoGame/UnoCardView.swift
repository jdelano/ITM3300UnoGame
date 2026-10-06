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
        GeometryReader { geometry in
            ZStack {
                // Card front (blue 7)
                cardChrome(color: color, ellipseColor: .white, size: geometry.size)
                
                cardSymbol(color: color, size: geometry.size.width * 0.5)
                
                cornerSymbols(size: geometry.size.width * 0.15)
            }
        }
    }
    
    private func cardChrome(color: Color, ellipseColor: Color, size: CGSize) -> some View {
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
                .frame(width: size.width * 0.75, height: size.height * 0.7)
        }
    }
    
    private func cornerSymbols(size: CGFloat) -> some View {
        VStack {
            HStack {
                cardSymbol(color: .white, size: size)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                cardSymbol(color: .white, size: size)
                    .rotationEffect(.degrees(180))
            }
        }
        .padding(20)
    }
    
    @ViewBuilder
    private func cardSymbol(color: Color, size: CGFloat) -> some View {
        let symbolSize = size * 2
        switch card.type {
            case .skip:
                SkipSymbol(color: color)
                    .frame(width: symbolSize, height: symbolSize)
            case .reverse:
                ReverseSymbol(color: color)
                    .frame(width: symbolSize, height: symbolSize)
            default:
                
                Text(symbol)
                    .font(.system(size: size))
                    .bold()
                    .underline(symbol == "6" || symbol == "9", color: color)
                    .foregroundStyle(color)
        }
        
    }
}

#Preview {
    UnoCardView(card: UnoCard(type: .skip, color: .green), viewModel: UnoGameViewModel())
//    UnoCardView(card: UnoCard(type: .reverse, color: .green), viewModel: UnoGameViewModel())
//    UnoCardView(card: UnoCard(type: .drawTwo, color: .green), viewModel: UnoGameViewModel())
    
}
