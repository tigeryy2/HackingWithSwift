//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Tiger Yang on 9/14/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        ExampleView3()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
