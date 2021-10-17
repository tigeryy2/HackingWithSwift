//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Tiger Yang on 10/15/21.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        // load our saved data
        if let loadedArray = UserDefaults.standard.object(forKey: saveKey) as? [String] {
            self.resorts = Set(loadedArray)
            return
        }
        
        // if unable to load and cast... use empty array
        self.resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        // since sets aren't supported, first convert to [String]
        let resortsArray = resorts.sorted()
        UserDefaults.standard.set(resortsArray, forKey: saveKey)
    }
}
