//
//  DiceRollApp.swift
//  DiceRoll
//
//  Created by Tiger Yang on 10/10/21.
//

import SwiftUI

@main
struct DiceRollApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
