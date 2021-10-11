//
//  DiceView.swift
//  DiceRoll
//
//  Created by Tiger Yang on 10/10/21.
//

import SwiftUI

struct DiceView: View {
    @Binding var rollResult: Int
    
    let numberOfSides: Int
    let numberOfDice: Int
    /// Duration of roll animation
    let rollDuration: Int
    
    init(rollResult: Binding<Int>, numberOfSides: Int, numberOfDice: Int, rollDuration: Int) {
        self._rollResult = rollResult
        self.numberOfSides = numberOfSides
        self.numberOfDice = numberOfDice
        self.rollDuration = rollDuration
    }
    
    var body: some View {
        Text("\(self.rollResult)")
            .font(.system(size: 200))
            .frame(maxWidth: 200, maxHeight: 200)
            .background(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 12))
            
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(rollResult: .constant(5), numberOfSides: 6, numberOfDice: 2, rollDuration: 5)
    }
}
