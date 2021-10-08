//
//  Card.swift
//  Flashzilla
//
//  Created by Tiger Yang on 10/6/21.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String

    static var example: Card {
        Card(prompt: "Who is the best QB in the NFL?", answer: "Tom Brady")
    }
}
