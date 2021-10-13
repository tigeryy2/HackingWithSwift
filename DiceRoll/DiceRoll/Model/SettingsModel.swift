//
//  SettingsModel.swift
//  DiceRoll
//
//  Created by Tiger Yang on 10/10/21.
//

import Foundation

enum settingsUserDefaultKeys: String {
    case numberOfDice = "numberOfDice"
    case numberOfSides = "numberOfSides"
}

struct settingsModel {
    /// Set default values for items in UserDefaults
    public static func setDefaultValues() {
        UserDefaults.standard.register(defaults: [settingsUserDefaultKeys.numberOfDice.rawValue : 2])
        UserDefaults.standard.register(defaults: [settingsUserDefaultKeys.numberOfSides.rawValue : 6])
    }
}
