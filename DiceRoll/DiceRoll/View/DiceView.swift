//
//  DiceView.swift
//  DiceRoll
//
//  Created by Tiger Yang on 10/10/21.
//

import CoreHaptics
import SwiftUI

struct DiceView: View {
    /// Number displayed on dice for animation or final result
    @State var displayedNumber: Int
    @State private var hapticEngine: CHHapticEngine?
    /// Roll progress, 0.0 to 1.0
    @State var rollProgress: Double = 1.0
    /// Final roll result
    @Binding var rollResult: Int
    
    /// Value for each side of the die
    let diceSides: [Int]
    /// Number of sides per die
    let numberOfSides: Int
    let numberOfDice: Int
    /// Duration of roll animation
    let rollDuration: Double
    
    init(rollResult: Binding<Int>, diceSides: [Int], numberOfSides: Int, numberOfDice: Int, rollDuration: Double) {
        self._rollResult = rollResult
        self.displayedNumber = rollResult.wrappedValue
        self.diceSides = diceSides
        self.numberOfSides = numberOfSides
        self.numberOfDice = numberOfDice
        self.rollDuration = rollDuration
    }
    
    var body: some View {
        Text("\(self.displayedNumber)")
            .font(.system(size: 200))
            // scale text to fit
            .scaledToFit()
            .minimumScaleFactor(0.5)
            .frame(maxWidth: 200, maxHeight: 200)
            .background(
                // animation "die" outline that doubles as the roll progress bar
                RoundedRectangle(cornerRadius: 15)
                    .trim(from: 0.0, to: rollProgress)
                    .stroke(lineWidth: 12)
                    .animation(.easeInOut)
            )
            .onChange(of: self.rollResult) {
                _ in
                // when parent view calculates and changes the rollResult, we know to initiate the roll animation
                rollDice()
            }
            .transition(.opacity)
            // prod SwiftUI into thinking this is a new view, triggering the transition
            .id("diceNumber\(self.displayedNumber)")
            .onAppear(perform: prepareHaptics)
            
    }
    
    /// Simple fibonaci number calculator
    func fib(_ n: Double) -> Double {
        guard n > 1 else { return n }
        return fib(n-1) + fib(n-2)
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    /// Runs full dice roll animation
    func rollDice() {
        self.rollProgress = 0
        
        var timeLeft = rollDuration
        var count = 1.0
        
        while timeLeft > 0 {
            let interval = fib(count) * 0.01
            timeLeft -= interval
            count += 1
            
            if timeLeft <= 0 {
                // last value shown should be the pre-calculated result
                DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                    self.rollProgress = 1.0
                    rollHaptic()
                    withAnimation(.easeInOut) {
                        self.displayedNumber = rollResult
                    }
                }
            } else {
                // otherwise, show a random value
                DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                    self.rollProgress += interval / rollDuration
                    rollHaptic()
                    withAnimation(.easeInOut) {
                        self.displayedNumber = rollDiceOnce()
                    }
                }
            }
        }
    }
    
    /// Calculates random value out of possible dice rolls
    func rollDiceOnce() -> Int {
        var value = 0
        for _ in 0 ..< self.numberOfDice {
            value += diceSides.randomElement()!
        }
        return value
    }
    
    func rollHaptic() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(rollResult: .constant(5), diceSides: [1, 2, 3, 4, 5, 6], numberOfSides: 6, numberOfDice: 2, rollDuration: 5)
    }
}
