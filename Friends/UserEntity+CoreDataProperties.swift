//
//  UserEntity+CoreDataProperties.swift
//  Friends
//
//  Created by Tiger Yang on 9/18/21.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

    public var wrappedAbout: String {
        self.about ?? "Some boring info here..."
    }

    public var wrappedAddress: String {
        self.address ?? "1 finite loop, Austin TX, 42069"
    }

    public var wrappedCompany: String {
        self.company ?? "The Meme Company"
    }

    public var wrappedEmail: String {
        self.email ?? "whoUsesHotmail@gmail.com"
    }

    public var wrappedId: String {
        self.id ?? "licenseAndRegistrationPls"
    }
    
    public var wrappedName: String {
        self.name ?? "no one"
    }

    public var wrappedRegistered: String {
        self.registered ?? "2041-01-01"
    }

    public var wrappedTags: String {
        self.tags ?? "some, tags, here"
    }

    public var friendArray: [FriendEntity] {
        let set = friends as? Set<FriendEntity> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }   
}

// MARK: Generated accessors for friends
extension UserEntity {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: FriendEntity)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: FriendEntity)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension UserEntity : Identifiable {

}
