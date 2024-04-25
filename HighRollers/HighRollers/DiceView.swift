//
//  DiceView.swift
//  HighRollers
//
//  Created by Daniel Budusan on 25.04.2024.
//

import SwiftUI

struct DiceView: View {
    var dice: Dice
    
    var body: some View {
        Text("\(dice.upSide)")
            .font(.largeTitle)
            .frame(width: 50 ,height: 50)
            .background(.blue)
            .foregroundStyle(.white)
        
    }
}

#Preview {
    DiceView(dice: Dice(sides: 7))
}
