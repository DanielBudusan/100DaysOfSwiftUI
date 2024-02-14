//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Daniel Budusan on 13.02.2024.
//

import SwiftUI



struct ContentView: View {
    @State private var moves = ["rock", "paper", "scissors"]
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var playerChoice = ""
    @State private var gameResult = Bool.random()
    @State private var score = 0
    @State private var showingScore = false
    @State private var alertTitle = ""
    @State private var round = 0
    @State private var endGame = false
    
    var scoreBoard: some View {
        VStack {
            Text("Round \(round) / 10")
            Text("Your score: \(score)")
                .foregroundStyle(.black)
                .font(.title.bold())
        }
    }
    
    @ViewBuilder var movesButtons: some View {
        Text("Choose your option:")
            .font(.system(size: 25).bold())
        
        ForEach(0..<3){ nr in
            Button(moves[nr]) {
                buttonTapped(nr)
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal)
            .frame(width: 350, height: 60)
            .background(Color.blue)
            .cornerRadius(20)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("The computer has chosen \(moves[computerChoice]) and you should \(gameResult ? "win" : "lose")")
                .padding()
                .font(.system(size: 30))
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .multilineTextAlignment(.center)
            
            Spacer()
            movesButtons
            Spacer()
            scoreBoard
        }
        
        .alert(alertTitle, isPresented: $showingScore) {
            Button("Continue", action: newRound)
        } message: {
            Text("score: \(score) ")
        }
        
        .alert("Game has ended", isPresented: $endGame) {
            Button("Rest game", action: resetGame)
        } message: {
            Text("Your score \(score)")
        }
    }
    
    func buttonTapped (_ number: Int) {
        round += 1
        playerChoice = moves[number]
        let compChoice = moves[computerChoice]
        var wonRound = false
        
        if gameResult {
            if compChoice == "rock" && playerChoice == "paper" {
                wonRound = true
            } else if compChoice == "paper" && playerChoice == "scissors" {
                wonRound = true
            } else if compChoice == "scissors" && playerChoice == "rock" {
                wonRound = true
            }
        }
        
        if !gameResult {
            if compChoice == "rock" && playerChoice == "scissors" {
                wonRound = true
            } else if compChoice == "paper" && playerChoice == "rock" {
                wonRound = true
            } else if compChoice == "scissors" && playerChoice == "paper" {
                wonRound = true
            }
        }
        
        if wonRound {
            score += 1
            alertTitle = "+ 1 point"
        } else if score > 0 {
            score -= 1
            alertTitle = "- 1 point"
        }
        showingScore = true
    }
    
    func newRound() {
        if round == 10 {
            endGame = true
        }
        computerChoice = Int.random(in: 0...2)
        gameResult = Bool.random()
    }
    
    func resetGame() {
        score = 0
        round = 0
    }
}

#Preview {
    ContentView()
}

