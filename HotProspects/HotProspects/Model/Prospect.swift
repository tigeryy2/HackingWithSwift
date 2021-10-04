//
//  Prospect.swift
//  HotProspects
//
//  Created by Tiger Yang on 10/3/21.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "NoOne"
    var emailAddress = ""
    // can only set this value within this file, read anywhere
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    static let saveKey = "SavedProspects"
    
    init() {
        // try to load from userdefaults
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        
        // if loading fails... just init empty array
        self.people = []
    }
    
    func add(_ prospect: Prospect) {
        self.people.append(prospect)
        self.save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(self.people) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    /// Toggles the given prospect's 'isContacted' attribute
    func toggle(_ prospect: Prospect) {
        // note that objectWillChange shoudl go before the actual change
        objectWillChange.send()
        prospect.isContacted.toggle()
        
        // save to userdefaults
        self.save()
    }
    
    /// Toggles the given prospect's 'isContacted' attribute to the given state
    func toggle(_ prospect: Prospect, to isContacted: Bool) {
        if prospect.isContacted != isContacted {
            objectWillChange.send()
            prospect.isContacted.toggle()
            
            self.save()
        }
    }
}
