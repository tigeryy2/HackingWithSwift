//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by Tiger Yang on 9/6/21.
//

import Foundation

extension Bundle {
    // generic decode function. Works with whatever type we pass it.
    // swift will not be able to infer types, so would need to explicitly tell swift what the expected return type is
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "y-MM-dd"    // Case sensitive
        decoder.dateDecodingStrategy = .formatted(dateformatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
