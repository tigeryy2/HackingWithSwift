//
//  FlashzillaApp.swift
//  Flashzilla
//
//  Created by Tiger Yang on 10/5/21.
//

import SwiftUI

@main
struct FlashzillaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
