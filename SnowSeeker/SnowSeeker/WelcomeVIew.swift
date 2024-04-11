//
//  WelcomeVIew.swift
//  SnowSeeker
//
//  Created by Daniel Budusan on 10.04.2024.
//

import SwiftUI

struct WelcomeVIew: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)
            
            Text("Please select a resort from left menu")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    WelcomeVIew()
}
