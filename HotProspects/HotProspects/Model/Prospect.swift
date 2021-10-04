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
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
    
    /// Toggles the given prospect's 'isContacted' attribute
    func toggle(_ prospect: Prospect) {
        // note that objectWillChange shoudl go before the actual change
        objectWillChange.send()
        prospect.isContacted.toggle()
    }
    
    /// Toggles the given prospect's 'isContacted' attribute to the given state
    func toggle(_ prospect: Prospect, to isContacted: Bool) {
        objectWillChange.send()
        if prospect.isContacted != isContacted {
            prospect.isContacted.toggle()
        }
    }
}
