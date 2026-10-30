//
//  SettingsView.swift
//  UnoGame
//
//  Created by John Delano on 10/30/26.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showsHints: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Toggle("Show playable hints", isOn: $showsHints)
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView(showsHints: .constant(true))
}
