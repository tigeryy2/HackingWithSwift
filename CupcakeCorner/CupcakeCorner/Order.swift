//
//  Order.swift
//  CupcakeCorner
//
//  Created by Tiger Yang on 9/12/21.
//

import Foundation

class Order: ObservableObject, Codable {
    // all the properties that need to be encoded/decoded
    enum CodingKeys: CodingKey {
        case type, quantity, specialRequestEnabled, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
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
        // invalid if any fields are empty or just whitespace
        if (self.name.trimmingCharacters(in: .whitespaces).isEmpty || self.streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || self.city.trimmingCharacters(in: .whitespaces).isEmpty || self.zip.trimmingCharacters(in: .whitespaces).isEmpty) {
            return false
        }
        
        // zip must be an int, with 5 digits (us zip)
        if Int(self.zip) == nil  || self.zip.count != 5 {
            return false
        }
        
        return true
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
    
    required init(from decoder: Decoder) throws {
        // inits object, loading data using decoder
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.type = try container.decode(Int.self, forKey: .type)
        self.quantity = try container.decode(Int.self, forKey: .quantity)
        
        self.specialRequestEnabled = try container.decode(Bool.self, forKey: .specialRequestEnabled)
        self.extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        self.addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.streetAddress = try container.decode(String.self, forKey: .streetAddress)
        self.city = try container.decode(String.self, forKey: .city)
        self.zip = try container.decode(String.self, forKey: .zip)
        
    }
    
    init() {
        // inits object w/ blank data
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(specialRequestEnabled, forKey: .specialRequestEnabled)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
}
