//
//  AddView.swift
//  iExpense
//
//  Created by Tiger Yang on 9/6/21.
//

import SwiftUI

enum expenseType: String, CaseIterable {
    case personal = "personal"
    case business = "business"
}

struct AddView: View {
    @ObservedObject var expenses: Expenses
    
    // links to the view's environment, the "isPresented" from the parent
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var type: expenseType = .personal
    @State private var amount: String = ""
    @State private var showingValidationAlert: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(expenseType.allCases, id:\.rawValue) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing: Button("Save") {
                if let amountInt = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type.rawValue, amount: amountInt)
                    self.expenses.items.append(item)
                    // close the sheet
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    // data validation failed..
                    showingValidationAlert = true
                }
            })
        }
        .alert(isPresented: $showingValidationAlert) {
            Alert(title: Text("Invalid Data"), message: Text("Check your input, amount must be an integer!"), dismissButton: .cancel())
        }
    }
}

struct AddView_Previews: PreviewProvider {    
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
