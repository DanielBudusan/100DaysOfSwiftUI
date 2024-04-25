//
//  Dice.swift
//  HighRollers
//
//  Created by Daniel Budusan on 25.04.2024.
//

import SwiftUI

struct Dice: Identifiable {
    var id = UUID()
    let sides: Int
    var upSide: Int
    var offsetX: CGFloat = 0
    
    init(sides: Int) {
        self.sides = sides
        self.upSide = Int.random(in: 1...sides)
    }
    
}
