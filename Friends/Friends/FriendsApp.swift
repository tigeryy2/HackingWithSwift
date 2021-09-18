//
//  FriendsApp.swift
//  Friends
//
//  Created by Tiger Yang on 9/17/21.
//

import SwiftUI

@main
struct FriendsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
