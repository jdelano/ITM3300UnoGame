//
//  SkipSymbol.swift
//  UnoGame
//
//  Created by John Delano on 9/30/26.
//

import SwiftUI

struct SkipSymbol: Shape {
    func path(in rect: CGRect) -> Path {
        let side = min(rect.width, rect.height)
        let square = CGRect(x: rect.midX - side / 2, y: rect.midY - side / 2, width: side, height: side)
        
        var path = Path()
        path.addEllipse(in: square)
        
        let radius = side / 2
        let angle = Angle(degrees: -45).radians
        var slash = Path()
        slash.move(to: CGPoint(x: square.midX - radius * cos(angle),
                               y: square.midY - radius * sin(angle)))
        slash.addLine(to: CGPoint(x: square.midX + radius * cos(angle),
                                  y: square.midY + radius * sin(angle)))
        path.addPath(slash)
        return path.strokedPath(StrokeStyle(lineWidth: side * 0.05, lineCap: .round))
    }
}

#Preview {
    SkipSymbol()
}
