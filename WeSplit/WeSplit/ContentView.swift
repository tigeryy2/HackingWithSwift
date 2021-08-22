//
//  ContentView.swift
//  WeSplit
//
//  Created by Tiger Yang on 8/12/21.
//

import SwiftUI

struct ContentView: View {
    // since the struct might be a constant, normal vars wont work
    // using @State tells swift to store these values somewhere
    @State private var checkAmount: String = ""
    @State private var numberOfPeopleField: String = "2"
    @State private var tipPercentage: Int = 2
    
    let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    var totalCheck: Double {
        let tipPercent: Double = Double(tipPercentages[tipPercentage])
        let checkTotal: Double = Double(checkAmount) ?? 0
        
        return (checkTotal * (1 + (tipPercent / 100)))
    }
    var totalPerPerson: Double {
        let peopleCount: Double = Double(numberOfPeopleField) ?? 2
        return self.totalCheck / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Check Total")) {
                    // $ creates a 2 way binding.. changes in the text field are written back
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Number of People")) {
                    TextField("Number of People", text: $numberOfPeopleField)
                }
                
                Section(header: Text("Tip Percentage")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount Per Person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                        .foregroundColor(tipPercentage == 4 ? .red : .black)
                }
                
            }
            .navigationBarTitle(Text("WeSplit"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
