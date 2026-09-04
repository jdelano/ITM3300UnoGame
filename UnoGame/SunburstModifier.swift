//
//  SunburstModifier.swift
//  UnoGame
//
//  Created by John Delano on 9/2/26.
//

import SwiftUI

struct SunburstModifier: ViewModifier {
    let color: Color
    let accent: Color?
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(sunburstGradient(main: color, accent: color.opacity(0.75)))

    }
    
    private func sunburstGradient(main: Color, accent: Color) -> AngularGradient {
        let bands = (0..<20).flatMap { _ in [main, accent] }
        return AngularGradient(colors: bands, center: .center)
    }

}

extension View {
    func sunburst(color: Color, accent: Color? = nil) -> some View {
        self.modifier(SunburstModifier(color: color, accent: accent ?? color.opacity(0.75)))
    }
}


