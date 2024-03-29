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
    
    // animation related states
    @State private var flagAnimationAmount: [Double] = [0.0, 0.0, 0.0]
    @State private var flagOpacityAmount: [Double] = [1.0, 1.0, 1.0]
    
    // labels for voiceover, so the flag can be guessed
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
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
                        .rotation3DEffect(
                            .degrees(flagAnimationAmount[number]),
                            axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                        )
                        .opacity(self.flagOpacityAmount[number])
                        .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
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
            
            // for correct flag, triggered 360 spin
            withAnimation(.easeInOut(duration: 1)) {
                // trigger flag rotation animation
                self.flagAnimationAmount[number] += 360
            }
            
            // for other 2 flags, fade to 0% opacity
            for index in 0..<3 {
                if index != number {
                    withAnimation(.easeOut(duration: 2)) {
                        self.flagOpacityAmount[index] = 0.25
                    }
                }
            }
            
        } else {
            scoreTitle = """
                Oops, wrong flag 🥲
                That's the flag of \(countries[number])
                """
            score -= 1
            
            // for wrong 2 flags, fade to 0% opacity
            for index in 0..<3 {
                if index != randomCountry {
                    withAnimation(.easeOut(duration: 2)) {
                        self.flagOpacityAmount[index] = 0.0
                    }
                    
                    withAnimation(.easeInOut(duration: 0.5)) {
                        // trigger flag rotation animation
                        self.flagAnimationAmount[index] += 360
                    }
                }
            }
        }
        
        // trigger alert after flag is tapped
        showingScore = true
    }
    
    func resetFlags() {
        // shuffle list and regenerate random number
        countries.shuffle()
        randomCountry = Int.random(in: 0 ..< 3)
        
        // reset opacities
        flagOpacityAmount = [1.0, 1.0, 1.0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
