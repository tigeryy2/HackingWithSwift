//
//  Expense.swift
//  iExpense
//
//  Created by Tiger Yang on 9/6/21.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encodedItems = try? encoder.encode(items) {
                UserDefaults.standard.set(encodedItems, forKey: "Items")
            }
        }
    }
    
    init() {
        // tries to retrieve data from userdefaults
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            // "[ExpenseItem].self refers to the type
            if let decodedItems = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decodedItems
                return
            }
        }
        
        // if unable to retrieve, start with blank array
        self.items = []
    }
}

