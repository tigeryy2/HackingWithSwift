//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Tiger Yang on 9/11/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Cake Type", selection: self.$order.type) {
                        ForEach(0 ..< Order.types.count) {
                            Text("\(Order.types[$0])")
                        }
                    }
                    
                    Stepper(value: self.$order.quantity, in: 1 ... 10) {
                        Text("Quantity: \(self.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: self.$order.specialRequestEnabled.animation(), label: {
                        Text("Any Special Requests?")
                    })
                    
                    if self.order.specialRequestEnabled {
                        Toggle(isOn: self.$order.extraFrosting, label: {
                            Text("Add extra frosting")
                        })
                        
                        Toggle(isOn: self.$order.addSprinkles, label: {
                            Text("Add extra sprinkles")
                        })
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationBarTitle(Text("Cupcake Corner"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
