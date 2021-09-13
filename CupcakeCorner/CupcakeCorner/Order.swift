//
//  Order.swift
//  CupcakeCorner
//
//  Created by Tiger Yang on 9/12/21.
//

import Foundation

class Order: ObservableObject {
    // types of cakes that can be ordered
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    // cake info
    // type of cake to order (as index of types)
    @Published var type = 0
    @Published var quantity = 3

    @Published var specialRequestEnabled = false {
        // when special requests are disabled, make sure all requests are set to false
        didSet {
            self.extraFrosting = false
            self.addSprinkles = false
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    // address info
    @Published var name: String = ""
    @Published var streetAddress: String = ""
    @Published var city: String = ""
    @Published var zip: String = ""
    
    var addressIsValid: Bool {
        // address is valid if none of the field are empty
        !(self.name.isEmpty || self.streetAddress.isEmpty || self.city.isEmpty || self.zip.isEmpty)
    }
    
    var totalCost: Double {
        var cost = Double(self.quantity * 2)
        
        // add some for more complicated cakes
        cost += Double(type) / 2
        
        // $1 for extra frosting
        if self.extraFrosting {
            cost += Double(self.quantity * 1)
        }
        
        // $0.50 for sprinkles
        if self.addSprinkles {
            cost += Double(self.quantity) * 0.5
        }
        
        return cost
    }
    
}
