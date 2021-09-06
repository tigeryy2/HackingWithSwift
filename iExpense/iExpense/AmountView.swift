//
//  AmountView.swift
//  iExpense
//
//  Created by Tiger Yang on 9/6/21.
//

import SwiftUI

struct AmountView: View {
    let amount: Int
    
    var body: some View {
        if amount <= 10 {
            Text("$\(amount)")
                .font(.footnote)
                .foregroundColor(.green)
        } else if amount > 10 && amount < 100 {
            Text("$\(amount)")
                .font(.body)
                .foregroundColor(.yellow)
        } else {
            Text("$\(amount)")
                .font(.headline)
                .foregroundColor(.red)
        }
    }
}

struct AmountView_Previews: PreviewProvider {
    static var previews: some View {
        AmountView(amount: 101)
    }
}
