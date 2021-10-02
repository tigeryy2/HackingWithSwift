//
//  PhotoBookApp.swift
//  PhotoBook
//
//  Created by Tiger Yang on 10/1/21.
//

import SwiftUI

@main
struct PhotoBookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
