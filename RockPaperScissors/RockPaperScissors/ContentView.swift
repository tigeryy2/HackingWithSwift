//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Tiger Yang on 8/22/21.
//

import SwiftUI

enum objectChoices: String {
    case rock = "rock"
    case paper = "paper"
    case scissors = "scissors"
}

struct ContentView: View {
    @State private var winOrLose: Bool = Bool.random()
    @State private var choices: [objectChoices] = [objectChoices.rock, objectChoices.paper, objectChoices.scissors]
    @State private var choice: Int = Int.random(in: 0 ..< 3)
    
    @State private var alertTitle: String = ""
    @State private var alertShowing: Bool = false
    @State private var score: Int = 0
    
    var body: some View {
        VStack {
            VStack {
                Text("iPhone chooses")
                Text("\(choices[choice].rawValue)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Text("What choice")
                Text("\(winOrLose ? "wins" : "loses")?")
                    .font(.largeTitle)
                    .fontWeight(.black)
            }
            .font(.body)
            
            VStack(spacing: 30) {
                ForEach(choices, id: \.self) {
                    object in
                    RpsButtonView(objectChoice: object.rawValue) {
                        self.choiceTapped(object)
                    }
                }
            }
            
            // push everything to top...
            Spacer()
            
            Text("Score: \(score)")
        }
        .alert(isPresented: $alertShowing) {
            Alert(
                title: Text(alertTitle),
                message: Text("Your score is \(self.score)"),
                dismissButton: .default(Text("Continue?")) {
                    self.resetTurn()
                })
        }
        
    }
    
    func thisBeatsThat(this: objectChoices, that: objectChoices) -> Bool {
        
        switch this {
        case objectChoices.paper:
            switch that {
            case objectChoices.rock:
                return true
            case objectChoices.scissors:
                return false
            default:
                return false
            }
        case objectChoices.rock:
            switch that {
            case objectChoices.scissors:
                return true
            case objectChoices.paper:
                return false
            default:
                return false
            }
        case objectChoices.scissors:
            switch that {
            case objectChoices.paper:
                return true
            case objectChoices.rock:
                return false
            default:
                return false
            }
        }
    }
    
    func choiceTapped(_ thisChoice: objectChoices) {
        if (self.thisBeatsThat(this: thisChoice, that: choices[choice]) == winOrLose) {
            score += 1
            alertTitle = "Correct!"
        } else {
            score -= 1
            alertTitle = "Nope, try again?"
        }
        
        alertShowing = true
    }
    
    func resetTurn() {
        winOrLose = Bool.random()
        choice = Int.random(in: 0 ..< 3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
