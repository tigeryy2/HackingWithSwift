//
//  ExampleView2.swift
//  CoreDataProject
//
//  Created by Tiger Yang on 9/15/21.
//

import SwiftUI
import CoreData

struct ExampleView2: View {
    @Environment(\.managedObjectContext) var moc
        @FetchRequest(entity: Ship.entity(), sortDescriptors: [], predicate: NSPredicate(format: "universe IN %@", ["Our Universe", "Star Wars"])) var ships: FetchedResults<Ship>

        var body: some View {
            VStack {
                List(ships, id: \.self) { ship in
                    Text(ship.name ?? "Unknown name")
                }

                Button("Add Examples") {
                    let ship1 = Ship(context: self.moc)
                    ship1.name = "Enterprise"
                    ship1.universe = "Star Trek"

                    let ship2 = Ship(context: self.moc)
                    ship2.name = "Defiant"
                    ship2.universe = "Star Trek"

                    let ship3 = Ship(context: self.moc)
                    ship3.name = "Millennium Falcon"
                    ship3.universe = "Star Wars"

                    let ship4 = Ship(context: self.moc)
                    ship4.name = "Executor"
                    ship4.universe = "Star Wars"
                    
                    let ship5 = Ship(context: self.moc)
                    ship5.name = "Falcon Heavy"
                    ship5.universe = "Our Universe"

                    try? self.moc.save()
                }
            }
        }
}

struct ExampleView2_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView2()
    }
}
