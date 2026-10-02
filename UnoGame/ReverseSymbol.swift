//
//  ReverseSymbol.swift
//  UnoGame
//
//  Created by John Delano on 10/2/26.
//

import SwiftUI

struct ReverseSymbol: Shape {
    var color: Color
    
    func path(in rect: CGRect) -> Path {
        let shaft = CGSize(width: rect.width * 0.40, height: rect.height * 0.07)
        let offset = CGSize(width: rect.width * 0.05, height: rect.height * 0.045)
        
        let shaftRect = CGRect(x: rect.center.x - shaft.width / 2 + offset.width,
                               y: rect.center.y - shaft.height / 2 - offset.height,
                               width: shaft.width, height: shaft.height)
        
        var arrow = Path()
        arrow.addRoundedRect(in: shaftRect, cornerRadii: RectangleCornerRadii(topLeading: 25))
        
        let head = CGSize(width: rect.width * 0.125, height: rect.width * 0.25)
        arrow.move(to: CGPoint(x: shaftRect.maxX, y: shaftRect.midY - head.height / 2))
        arrow.addLine(to: CGPoint(x: shaftRect.maxX, y: shaftRect.midY + head.height / 2))
        arrow.addLine(to: CGPoint(x: shaftRect.maxX + head.width, y: shaftRect.midY))
        arrow.closeSubpath()

        
        arrow.addPath(arrow.rotated(by: .pi, around: rect.center))
        return arrow.rotated(by: -.pi / 4, around: rect.center)

    }
    
    var body: some View {
        fill(color)
    }
}

extension Path {
    func rotated(by angle: Double, around center: CGPoint) -> Path {
        applying(CGAffineTransform(translationX: center.x, y: center.y)
            .rotated(by: angle)
            .translatedBy(x: -center.x, y: -center.y))
    }
}

#Preview {
    ReverseSymbol(color: .blue)
}
