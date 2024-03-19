//
//  SwiftDataPracticeApp.swift
//  SwiftDataPractice
//
//  Created by Daniel Budusan on 13.03.2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataPracticeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
