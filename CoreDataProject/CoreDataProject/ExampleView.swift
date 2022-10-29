//
//  ExampleView.swift
//  CoreDataProject
//
//  Created by Tiger Yang on 9/15/21.
//

import SwiftUI

struct ExampleView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Wizard.entity(),
        sortDescriptors: [],
        animation: .default)
    private var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }

            Button("Add") {
                let wizard = Wizard(context: self.viewContext)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    if self.viewContext.hasChanges {
                        try self.viewContext.save()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
