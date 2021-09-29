//
//  Result.swift
//  BucketList
//
//  Created by Tiger Yang on 9/29/21.
//

import Foundation

// structs for encoding/decoding json to wikipedia

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        // return Json may or may not have these fields filled...
        terms?["description"]?.first ?? "No further information"
    }
    
    // needed to conform to comparable
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
