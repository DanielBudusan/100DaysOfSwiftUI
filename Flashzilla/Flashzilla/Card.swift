//
//  Card.swift
//  Flashzilla
//
//  Created by Daniel Budusan on 02.04.2024.
//

import Foundation

struct Card: Codable, Identifiable, Equatable {
    var id = UUID()
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "who is the prime minister of Romania ?", answer: "Marcel Ciolanu")
    
    static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.id == rhs.id
        }
}
