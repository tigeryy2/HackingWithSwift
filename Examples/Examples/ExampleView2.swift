//
//  ExampleView2.swift
//  Examples
//
//  Created by Tiger Yang on 9/12/21.
//

import SwiftUI

class User: ObservableObject, Codable {
    @Published var name = "Paul Hudson"
    
    // tells swift which properties should be saved and loaded
    enum CodingKeys: CodingKey {
        // each case is the name of a property that you want to be Codable
        case name
    }
    
    // "required" tells subclassers that this must be overriden to ensure all values are added
    // init tells swift how to decode from file
    required init(from decoder: Decoder) throws {
        // look for a container with the keys specified in our CodingKey
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // uses the cases from our CodingKey enum
        name = try container.decode(String.self, forKey: .name)
    }
    
    // how to encode into file, as part of Codable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct ExampleView2: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ExampleView2_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView2()
    }
}
