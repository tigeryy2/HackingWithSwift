//
//  RollView.swift
//  DiceRoll
//
//  Created by Tiger Yang on 10/10/21.
//

import SwiftUI

struct RollView: View {
    @State private var diceSides: [Int] = [1, 2, 3, 4, 5, 6]
    @State private var numberOfDice: Int = 2
    @State private var numberOfSides: Int = 6
    @State private var rollResult = 1
    
    var body: some View {
        VStack {
            Text("Feeling Lucky?")
                .font(.title)
            DiceView(rollResult: self.$rollResult, numberOfSides: numberOfSides, numberOfDice: numberOfDice, rollDuration: 5)
            Button(
                action: {
                    self.rollResult = diceSides.randomElement()!
                }) {
                    Text("Hit Me")
                        .font(.title)
                }
            
            HStack {
                // x Dice
                Text("\(numberOfDice)")
                Image(systemName: "dice.fill")
                
                // x sides
                Text("\(numberOfSides)")
                Image(systemName: "questionmark.square.fill")
            }
            .font(.title)
            .padding()
        }
        // load settings from UserDefaults
        .onAppear(perform: load)
    }
    
    func load() {
        self.numberOfDice = UserDefaults.standard.integer(forKey: settingsUserDefaultKeys.numberOfDice.rawValue)
        let sides = UserDefaults.standard.integer(forKey: settingsUserDefaultKeys.numberOfSides.rawValue)
        self.numberOfSides = sides
        
        self.diceSides = Array(1...sides)
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
