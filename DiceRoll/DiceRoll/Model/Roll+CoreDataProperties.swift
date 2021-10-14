//
//  Roll+CoreDataProperties.swift
//  DiceRoll
//
//  Created by Tiger Yang on 10/13/21.
//
//

import Foundation
import CoreData


extension Roll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Roll> {
        return NSFetchRequest<Roll>(entityName: "Roll")
    }

    @NSManaged public var numberOfDice: Int16
    @NSManaged public var numberOfSides: Int16
    @NSManaged public var result: Int16
    @NSManaged public var time: Date?

    public var wrappedTime: Date {
        self.time ?? Date()
    }
}

extension Roll : Identifiable {

}
