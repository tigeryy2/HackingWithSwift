//
//  ContentView.swift
//  iExpense
//
//  Created by Tiger Yang on 9/5/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                // since expenseItem conforms to "identifiable", no need to specify that the id should be used
                ForEach(expenses.items) {
                    item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        AmountView(amount: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle(Text("iExpense"))
            .navigationBarItems(
                trailing:
                    HStack {
                        EditButton()
                        Button(action: {
                            self.showingAddExpense = true
                        }) {
                            Image(systemName: "plus")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        }
                    }
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offsetts: IndexSet) {
        expenses.items.remove(atOffsets: offsetts)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
