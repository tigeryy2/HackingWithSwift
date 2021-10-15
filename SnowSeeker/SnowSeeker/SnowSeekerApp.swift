//
//  SnowSeekerApp.swift
//  SnowSeeker
//
//  Created by Tiger Yang on 10/13/21.
//

import SwiftUI

@main
struct SnowSeekerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
