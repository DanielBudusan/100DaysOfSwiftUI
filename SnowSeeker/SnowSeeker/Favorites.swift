//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Daniel Budusan on 11.04.2024.
//

import SwiftUI

@Observable
class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    init() {
        resorts = []
        load()
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    private func save() {
        UserDefaults.standard.set(Array(resorts), forKey: saveKey)
    }
    
    private func load() {
        if let savedResorts = UserDefaults.standard.array(forKey: saveKey) as? [String] {
            resorts = Set(savedResorts)
        }
    }
}
 
