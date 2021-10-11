//
//  SettingsView.swift
//  DiceRoll
//
//  Created by Tiger Yang on 10/10/21.
//

import SwiftUI

struct SettingsView: View {
    @State private var diceSides: Int
    @State private var numberOfDice: Int
    
    init() {
        self.numberOfDice = UserDefaults.standard.integer(forKey: settingsUserDefaultKeys.numberOfDice.rawValue)
        
        self.diceSides = UserDefaults.standard.integer(forKey: settingsUserDefaultKeys.numberOfSides.rawValue)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Choose your Die")) {
                    Picker("# of Sides", selection: self.$diceSides) {
                        ForEach(0..<101, id:\.self) {
                            // value of 0 signifies a custom dice
                            if $0 != 0 {
                                Text("\($0)")
                            } else {
                                Text("Custom Die")
                            }
                        }
                    }
                    .onChange(of: diceSides) {
                        _ in
                        saveSettings()
                    }
                    .pickerStyle(.automatic)
                    
                    // TODO custom dice handling
                }
                
                Section(header: Text("How Many Dice")) {
                    Picker("How many die?", selection: self.$numberOfDice) {
                        ForEach(1..<7, id:\.self) {
                            Text("\($0)")
                        }
                    }
                    .onChange(of: numberOfDice) {
                        _ in
                        saveSettings()
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle(Text("Settings"))
        }
    }
    
    /// Load settings from userdefaults
    private func loadSettings() {
        self.numberOfDice = UserDefaults.standard.integer(forKey: settingsUserDefaultKeys.numberOfDice.rawValue)
        
        self.diceSides = UserDefaults.standard.integer(forKey: settingsUserDefaultKeys.numberOfSides.rawValue)
    }
    
    /// Save settings from userdefaults
    private func saveSettings() {
        UserDefaults.standard.set(self.numberOfDice, forKey: settingsUserDefaultKeys.numberOfDice.rawValue)
        UserDefaults.standard.set(self.diceSides, forKey: settingsUserDefaultKeys.numberOfSides.rawValue)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
