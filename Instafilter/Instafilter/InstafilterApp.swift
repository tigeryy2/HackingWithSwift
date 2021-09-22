//
//  InstafilterApp.swift
//  Instafilter
//
//  Created by Tiger Yang on 9/20/21.
//

import SwiftUI

@main
struct InstafilterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
