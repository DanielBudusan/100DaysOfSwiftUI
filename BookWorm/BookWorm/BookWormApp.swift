//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Daniel Budusan on 11.03.2024.
//

import SwiftUI
import SwiftData

@main
struct BookWormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
