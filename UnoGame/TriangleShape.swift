//
//  TriangleShape.swift
//  UnoGame
//
//  Created by John Delano on 9/30/26.
//

import SwiftUI

struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    TriangleShape()
        .frame(width: 100, height: 100)
        .rotationEffect(Angle(degrees: 45))
}
