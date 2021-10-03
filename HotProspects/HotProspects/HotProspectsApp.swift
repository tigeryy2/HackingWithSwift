//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Tiger Yang on 10/2/21.
//

import SwiftUI

@main
struct HotProspectsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
