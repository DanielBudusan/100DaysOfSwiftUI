//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Daniel Budusan on 28.03.2024.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
