//
//  Mission.swift
//  Moonshot
//
//  Created by Tiger Yang on 9/6/21.
//

import Foundation


struct Mission: Codable, Identifiable {
    // by using multiple (nested) structs, we can represent json that contains hierarchies
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    // not all missions have a launch date
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var imageName: String {
        return "apollo\(id)"
    }
    
    var displayName: String {
        return "Apollo \(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = self.launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "None"
        }
    }
}
