//
//  ContentView.swift
//  HighRollers
//
//  Created by Daniel Budusan on 23.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var dicePool = [Dice]()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var sides: Double = 4
    @State private var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns) {
                ForEach(dicePool) { dice in
                    DiceView(dice: dice)
                        .offset(x: dice.offsetX)
                }
            }
        }
        .onReceive(timer) { _ in
            shake()
        }
        .onAppear() {
            stopTimer()
        }
        
        HStack {
            Button("Shake") {
                startTimer()
            }
            .frame(width: 100, height: 40)
            .background(.blue)
            .foregroundStyle(.white)
            .padding()
            
            Button("Stop") {
                stopTimer()
            }
            .frame(width: 100, height: 40)
            .background(.blue)
            .foregroundStyle(.white)
            .padding()
        }
        
        Button("Add Dice") {
            dicePool.append(Dice(sides: Int(sides)))
        }
        .frame(width: 100, height: 40)
        .background(.blue)
        .foregroundStyle(.white)
        .padding()
        
        Slider(value: $sides, in: 4...100, step: 2)
        Text("Select sides nr: \(sides.formatted())")
        
    }
    
    func shake() {
        dicePool.indices.forEach { index in
            withAnimation(Animation.easeInOut(duration: 0.1)) {
                dicePool[index].offsetX = CGFloat.random(in: -5...5)
                dicePool[index].upSide = Int.random(in: 1...dicePool[index].sides)
            }
        }
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    }
}

#Preview {
    ContentView()
}
