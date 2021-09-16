//
//  ExampleView3.swift
//  CoreDataProject
//
//  Created by Tiger Yang on 9/15/21.
//

import SwiftUI

struct ExampleView3: View {
    @Environment(\.managedObjectContext) var objectContext
    @State private var lastNameFilter = "d"
    @State private var predicate: Predicate = .contains
    
    var body: some View {
        VStack {
            // list of matching singers
            FilteredList(
                filterKey: "lastName",
                filterValue: self.lastNameFilter,
                predicate: self.predicate,
                sortDescriptors: [NSSortDescriptor(keyPath: \Singer.lastName, ascending: true)]) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: self.objectContext)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.objectContext)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.objectContext)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                let notAdele = Singer(context: self.objectContext)
                notAdele.firstName = "Nodele"
                notAdele.lastName = "Akins"
                
                try? self.objectContext.save()
            }
            
            Button("Show lastName contains dele") {
                self.lastNameFilter = "d"
                self.predicate = .contains
            }
            
            Button("Show S") {
                self.lastNameFilter = "S"
                self.predicate = .beginsWith
            }
        }
    }
}

struct ExampleView3_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView3()
    }
}
