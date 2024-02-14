//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Daniel Budusan on 08.02.2024.
//

import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 45).weight(.bold))
            .foregroundStyle(.white)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(TitleStyle())
    }
}

struct FlagImage: View {
    var name: String
    var body: some View {
        Image(name)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = [0,0]
    @State private var endGame = false
    
    var flagBox: some View {
        VStack(spacing: 15) {
            VStack {
                Text("Tap the flag of")
                    .foregroundColor(.secondary)
                    .font(.subheadline.weight(.heavy))
                Text(countries[correctAnswer])
                    .font(.largeTitle.weight(.bold))
            }
            
            ForEach(0..<3){ number in
                Button {
                    flagTapped(number)
                } label: {
                     FlagImage(name: countries[number])
                }
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
    }
    
    var scoreBoard: some View {
        Text("Correct: \(score[0])     Wrong: \(score[1]) ")
            .foregroundStyle(.white)
            .font(.title.bold())
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ],center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the flag")
                    .titleStyle()
                flagBox
                Spacer()
                Spacer()
                scoreBoard
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Correct: \(score[0])     Wrong: \(score[1]) ")
        }
        
        .alert("Game has ended", isPresented: $endGame) {
            Button("Rest game", action: resetGame)
        } message: {
            if score[0] > score[1] {
                Text("You Won !")
            } else {
                Text("You Lost !")
            }
        }
    }
    
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct answer"
            score[0] += 1
        } else {
            scoreTitle = "Wrong answer, that was the flag of \(countries[number])"
            score[1] += 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        if score[0] + score[1] == 9 {
            endGame = true
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        score = [0,0]
    }
}

#Preview {
    ContentView()
}
