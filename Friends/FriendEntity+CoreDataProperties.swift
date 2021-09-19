//
//  FriendEntity+CoreDataProperties.swift
//  Friends
//
//  Created by Tiger Yang on 9/18/21.
//
//

import Foundation
import CoreData


extension FriendEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendEntity> {
        return NSFetchRequest<FriendEntity>(entityName: "FriendEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: UserEntity?

    public var wrappedId: String {
        self.id ?? "someIdHere"
    }

    public var wrappedName: String {
        self.name ?? "no one"
    }
}

extension FriendEntity : Identifiable {

}
