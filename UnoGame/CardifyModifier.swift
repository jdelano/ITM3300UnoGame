//
//  CardifyModifier.swift
//  UnoGame
//
//  Created by John Delano on 9/2/26.
//

import SwiftUI

struct CardifyModifier: ViewModifier, Animatable {
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }

    func body(content: Content) -> some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            ZStack {
                // White outer card with black border
                rectangle(width: width)
                    .fill(.white)
                    .strokeBorder(.black)

                if isFaceUp {
                    content
                } else {
                    cardBack(size: geometry.size)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                }
            }
        }
        .aspectRatio(2.0 / 3.0, contentMode: .fit)
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))

        //        .frame(width: 200, height: 300)
    }
    
    private func rectangle(width: CGFloat) -> some InsettableShape {
        RoundedRectangle(cornerRadius: width * 0.075)
    }
    
    @ViewBuilder
    private func cardBack(size: CGSize) -> some View {
        let width = size.width
        // Black inner background, inset from the border, with the red
        // tilted ellipse layered on top. The ellipse is placed inside the
        // rectangle's overlay and the whole group is clipped to the same
        // rounded rectangle so the ellipse can't spill past the black area.
        // Padding is applied last so the clip shape matches the inset size.
        rectangle(width: width)
            .overlay {
                Ellipse()
                    .sunburst(color: .red, accent: .red.opacity(0.9))
                    .rotationEffect(.degrees(45))
                    .frame(width: size.width * 0.7, height: size.height * 0.7)
            }
            .clipShape(rectangle(width: width))
            .padding(width * 0.07)

        // UNO logo with gradient, tilted, with shadow
        Text("UNO")
            .font(.system(size: size.width * 0.35))
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

#Preview {
    Text("Card")
        .cardify(isFaceUp: false)
        .frame(width: 70)
}
