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
            cardBack()
            cardFront(symbol: "5", color: .blue)
            cardFront(symbol: "9", color: .red)
        }
    }
    
    private func cardBack() -> some View {
        ZStack {
            cardChrome(color: .black, ellipseColor: .red)
            // UNO logo with gradient, tilted, with shadow
            Text("UNO")
                .font(.system(size: 60))
                .bold()
                .fixedSize()
                .foregroundStyle(
                    LinearGradient(
                        colors: [.yellow, .white],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .rotationEffect(.degrees(-10))
                .shadow(color: .black, radius: 5, x: -3, y: 5)
        }
        .frame(width: 200, height: 300)
    }
    
    private func cardFront(symbol: String, color: Color) -> some View {
        // Card front (blue 7)
        ZStack {
            cardChrome(color: color, ellipseColor: .white)
            
            Text(symbol)
                .font(.system(size: 100))
                .bold()
                .underline(symbol == "6" || symbol == "9", color: color)
                .foregroundStyle(color)
            
            cornerSymbols(symbol: symbol)
        }
        .frame(width: 200, height: 300)
    }
    
    private func cardChrome(color: Color, ellipseColor: Color) -> some View {
        ZStack {
            // White outer card with black border
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .strokeBorder(.black)
            
            // Black inner background, inset from the border
            RoundedRectangle(cornerRadius: 15)
                .fill(sunburstGradient(main: color, accent: color.opacity(0.75)))
                .padding(10)
            
            // Red tilted ellipse in the center
            Ellipse()
                .fill(ellipseColor)
                .rotationEffect(.degrees(45))
                .frame(width: 150, height: 200)
        }
    }
    
    private func cornerSymbols(symbol: String) -> some View {
        VStack {
            HStack {
                cornerSymbol(symbol: symbol)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                cornerSymbol(symbol: symbol)
                    .rotationEffect(.degrees(180))
            }
        }
        .padding(20)
    }
    
    private func sunburstGradient(main: Color, accent: Color) -> AngularGradient {
        let bands = (0..<20).flatMap { _ in [main, accent] }
        return AngularGradient(colors: bands, center: .center)
    }
    
    private func cornerSymbol(symbol: String) -> some View {
        Text(symbol)
            .font(.system(size: 30))
            .bold()
            .underline(symbol == "6" || symbol == "9", color: .white)
            .foregroundStyle(.white)
    }
    
}

#Preview {
    ContentView()
}



