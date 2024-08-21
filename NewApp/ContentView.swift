//
//  ContentView.swift
//  NewApp
//
//  Created by Adil Maxutov on 08.06.2024.
//

import SwiftUI


struct ContentView: View {
    
    @State private var countries = ["Brazil", "Britain", "France", "Germany", "Kazakhstan", "Norway", "Portugal", "Sweden", "USA"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.gray, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 40) {
                VStack {
                    Text("Choose flag: ")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .cornerRadius(30)
                    }
                }
                
                Text("Total Score: \(score)")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
        } .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Total Score: \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct Answer!"
            score += 1
        } else {
            scoreTitle = "Incorrect! It's \(countries[number])'s flag"
            score -= 1
        }
    }
}






#Preview {
    ContentView()
}
