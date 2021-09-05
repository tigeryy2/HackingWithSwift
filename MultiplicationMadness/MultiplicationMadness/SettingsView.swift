//
//  SettingsView.swift
//  MultiplicationMadness
//
//  Created by Tiger Yang on 9/3/21.
//

import SwiftUI

struct SettingsView: View {
    @Binding var tableLowerBound: Int
    @Binding var tableHigherBound: Int
    @Binding var numberQuestions: Int
    @Binding var highScore: Int
    
    @State public var startButtonAction: (() -> Void)
    
    let lowestLowBound: Int = 1
    let highestHighBound: Int = 12
    let maxQuestions: Int = 20
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Table Range")) {
                    Picker(selection: $tableLowerBound, label: Text("From"), content: {
                        ForEach(lowestLowBound ..< highestHighBound + 1) {
                            Text("\($0)")
                        }
                    })
                    Picker(selection: $tableHigherBound, label: Text("To"), content: {
                        ForEach(lowestLowBound ..< highestHighBound + 1) {
                            Text("\($0)")
                        }
                    })
                }
                
                Section(header: Text("How Many Questions?")) {
                    Picker(selection: $numberQuestions, label: Text("How Many Questions?"), content: {
                        ForEach(0 ..< maxQuestions + 1) {
                            if $0 == 0 {
                                Text("All")
                            } else {
                                Text("\($0)")
                            }
                        }
                    })
                    .pickerStyle(WheelPickerStyle())
                    .labelsHidden()
                }
                
                Section(header: Text("Start Game?")) {
                    Button(action: {
                        startButtonAction()
                    }) {
                        Image(systemName: "multiply.square")
                            .renderingMode(.original)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .font(.system(size: 50.0, weight: .bold))
                    }
                }
                
                Section(header: Text("High Score:")) {
                    Text("\(highScore)")
                        .frame(maxWidth: .infinity)
                        .font(.largeTitle)
                }
            }
            .navigationBarTitle(Text("Settings"), displayMode: .inline)
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            tableLowerBound: .constant(1),
            tableHigherBound: .constant(6),
            numberQuestions: .constant(20),
            highScore: .constant(0)) {
            print("Testing...")
        }
    }
}
