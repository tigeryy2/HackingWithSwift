//
//  Habits.swift
//  Habits
//
//  Created by Tiger Yang on 9/10/21.
//

import Foundation

struct Habit: Codable, Identifiable, Hashable {
    let id: UUID
    var name: String
    var description: String
    var completedCount: Double
}

class Habits: ObservableObject {
    @Published var habits = [Habit]() {
        // run whenever changes made to array, to save to userdefaults
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
        
    init() {
        // attempt to read from userdefaults
        if let habits = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habit].self, from: habits) {
                self.habits = decoded
                return
            }
        }
        
        // else, loading failed...
        //self.habits = [Habit(id: UUID(), name: "Test", description: "Test description", completedCount: 0.0)]
        self.habits = []
    }
}
