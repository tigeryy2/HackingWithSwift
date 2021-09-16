//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Tiger Yang on 9/15/21.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var origin: Country?

    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
    
}

extension Candy : Identifiable {

}
