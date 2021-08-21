//
//  ContentView.swift
//  ConvertIt
//
//  Created by Tiger Yang on 8/18/21.
//

import SwiftUI

// since the default .cup is the "legal" cup...
// define a custom cup
extension UnitVolume {
   static let usCup = UnitVolume(symbol: "USCup", converter: UnitConverterLinear(coefficient: 0.236588))
}

struct ContentView: View {
    @State private var inputValueText = ""
    @State private var inputUnit = 1
    @State private var outputUnit = 2
    
    private let units: [String: UnitVolume] =
        ["cups": .usCup,
         "tablespoons": .tablespoons,
         "teaspoons": .teaspoons,
         "pints": .pints,
         "liters": .liters,
         "fluid ounces": .fluidOunces]
    
    private var inputValue: Double {
        Double(inputValueText) ?? 0
    }
    
    private var outputValue: Double {
        let input = Measurement(value: inputValue, unit: Array(units.values)[inputUnit])
        let output = input.converted(to: Array(units.values)[outputUnit])
        
        return Double(output.value)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Value", text: $inputValueText)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Input Units")) {
                    Picker("Input Units", selection: $inputUnit) {
                        ForEach(0 ..< units.keys.count) {
                            Text(Array(units.keys)[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                Section(header: Text("Output Units")) {
                    Picker("Output Units", selection: $outputUnit) {
                        ForEach(0 ..< units.keys.count) {
                            Text(Array(units.keys)[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                Section(header: Text("Output")) {
                    Text("\(outputValue, specifier: "%.3f")")
                }
            }
            .navigationBarTitle(Text("Convert It"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
