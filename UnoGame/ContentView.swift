//
//  ContentView.swift
//  UnoGame
//
//  Created by John Delano on 8/19/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            // UNO Back of Card
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
                    .fixedSize()
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, .yellow],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .rotationEffect(Angle(degrees: -10))
                    .shadow(color: .black, radius: 5, x: -3, y: 5)
            }
            .frame(width: 200, height: 300)
            
            // UNO Front of Card
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .strokeBorder(.black)
                RoundedRectangle(cornerRadius: 15)
                    .fill(.blue)
                    .padding(10)
                Ellipse()
                    .fill(.white)
                    .rotationEffect(Angle(degrees: 45))
                    .frame(width: 150, height: 200)
                Text("7")
                    .font(.system(size: 100))
                    .bold()
                    .foregroundStyle(.blue)
                VStack {
                    HStack {
                        Text("7")
                            .font(.system(size: 30))
                            .bold()
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Text("7")
                            .font(.system(size: 30))
                            .bold()
                            .foregroundStyle(.white)
                            .rotationEffect(Angle(degrees: 180))

                    }
                }
                .padding(20)
                    
                
                    
            }
            .frame(width: 200, height: 300)

        }
    }
} 

#Preview {
    ContentView()
}
