//
//  ContentView.swift
//  UnoGame
//
//  Created by John Delano on 8/19/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .strokeBorder(.black)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
                .padding(10)
            Ellipse()
                .fill(Color.red)
                .rotationEffect(Angle(degrees: 45))
                .frame(width: 150, height: 200)
            Text("UNO")
                .font(.system(size: 60))
                .bold()
                .foregroundStyle(
                    LinearGradient(
                        colors: [.yellow, .white],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .rotationEffect(Angle(degrees: -10))
                .shadow(color: .black, radius: 5, x: -3, y: 5)
        }
        .frame(width: 200, height: 300)
    }
}

#Preview {
    ContentView()
}
