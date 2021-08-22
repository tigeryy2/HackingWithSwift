//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tiger Yang on 8/19/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var score: Int = 0
    
    @State private var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var randomCountry: Int = Int.random(in: 0 ..< 3)
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.15)]),
                startPoint: .bottom,
                endPoint: .top)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    
                    Text("\(countries[randomCountry])")
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                VStack(spacing: 20) {
                    ForEach(0 ..< 3) {
                        number in
                        Button(action: {
                            self.flagTapped(number)
                        }) {
                            FlagView(image: Image(self.countries[number]))
                        }
                    }
                    // spacer pushes everything up towards the top
                    Spacer()
                    Text("Score: \(score)")
                }
                
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(
                title: Text(scoreTitle),
                message: Text("Your score is \(self.score)"),
                dismissButton: .default(Text("Continue")) {
                    // action taken upon dismissing the alert
                    self.resetFlags()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        // action upon tapping flag
        if number == randomCountry {
            scoreTitle = "Correct, great job!"
            score += 1
        } else {
            scoreTitle = """
                Oops, wrong flag 🥲
                That's the flag of \(countries[number])
                """
            score -= 1
        }
        
        // trigger alert after flag is tapped
        showingScore = true
    }
    
    func resetFlags() {
        // shuffle list and regenerate random number
        countries.shuffle()
        randomCountry = Int.random(in: 0 ..< 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
