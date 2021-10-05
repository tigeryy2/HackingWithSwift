//
//  DocumentUtils.swift
//  HotProspects
//
//  Created by Tiger Yang on 10/4/21.
//

import SwiftUI

struct DocumentUtils {
    enum DocumentError: Error {
        case loadError
        case saveError
    }
    
    /// Get this app's documents directory
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func load<T: Codable>(from fileName: String) throws -> T {
        let fileUrl = DocumentUtils.getDocumentsDirectory().appendingPathComponent(fileName)
        
        if let data = try? Data(contentsOf: fileUrl) {
            if let decoded = try? JSONDecoder().decode(T.self, from: data) {
                return decoded
            }
        }
        
        throw DocumentError.loadError
    }
    
    static func save(data: Data, to fileName: String) throws {
        let fileUrl = DocumentUtils.getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileUrl, options: [.atomic, .completeFileProtection])
        } catch {
            throw DocumentError.saveError
        }
    }
}
