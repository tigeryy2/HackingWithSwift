//
//  Astronaut.swift
//  Moonshot
//
//  Created by Tiger Yang on 9/6/21.
//

import Foundation

// representation of data from astronauts.json
struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
