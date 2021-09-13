//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Tiger Yang on 9/12/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text("Your Total is $\(self.order.totalCost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button(action: {
                        // something here..
                    }) {
                        Text("Place Order")
                    }
                }
            }
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
