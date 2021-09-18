//
//  Users.swift
//  Friends
//
//  Created by Tiger Yang on 9/17/21.
//

import Foundation

// mirrors json @ https://www.hackingwithswift.com/samples/friendface.json

struct User: Decodable {
    struct Friend: Decodable {
        let id: String
        let name: String
    }
    
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}


