//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Tiger Yang on 9/6/21.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}
