//
//  RollView.swift
//  DiceRoll
//
//  Created by Tiger Yang on 10/10/21.
//

import SwiftUI

struct RollView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var diceSides: [Int] = [1, 2, 3, 4, 5, 6]
    @State private var numberOfDice: Int = 2
    @State private var numberOfSides: Int = 6
    @State private var rollResult = 1
    
    var body: some View {
        VStack {
            Text("Feeling Lucky?")
                .font(.title)
            DiceView(rollResult: self.$rollResult, diceSides: self.diceSides, numberOfSides: numberOfSides, numberOfDice: numberOfDice, rollDuration: 5.0)
            Button(
                action: {
                    // calculate roll result
                    self.rollDice()
                    
                    // add results to coreData
                    addRollResult()
                }) {
                    Text("Roll Dice")
                        .font(.title)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 25).stroke())
                        .padding(.top)
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
    
    private func addRollResult() {
        withAnimation {
            let newRoll = Roll(context: viewContext)
            newRoll.time = Date()
            newRoll.numberOfSides = Int16(self.numberOfSides)
            newRoll.numberOfDice = Int16(self.numberOfDice)
            newRoll.result = Int16(self.rollResult)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func load() {
        // set default values, so we don't just get zeros
        settingsModel.setDefaultValues()
        
        self.numberOfDice = UserDefaults.standard.integer(forKey: settingsUserDefaultKeys.numberOfDice.rawValue)
        let sides = UserDefaults.standard.integer(forKey: settingsUserDefaultKeys.numberOfSides.rawValue)
        self.numberOfSides = sides
        
        self.diceSides = Array(1...sides)
    }
    
    public func rollDice() {
        self.rollResult = 0
        for _ in 0 ..< self.numberOfDice {
            self.rollResult += diceSides.randomElement()!
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
