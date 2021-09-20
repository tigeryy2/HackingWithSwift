//
//  FriendListView.swift
//  Friends
//
//  Created by Tiger Yang on 9/19/21.
//

import SwiftUI
import CoreData

struct FriendListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var friendRequest: FetchRequest<UserEntity>
    var userRequest: FetchRequest<UserEntity>
    
    var fetchedFriends: FetchedResults<UserEntity> {
        friendRequest.wrappedValue
    }
    var fetchedUsers: FetchedResults<UserEntity> {
        userRequest.wrappedValue
    }
    
    init(friendIds: [String]) {
        self.friendRequest = FetchRequest<UserEntity>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "id IN %@", friendIds))
        
        self.userRequest = FetchRequest<UserEntity>(
            sortDescriptors: [])
    }
    
    var body: some View {
        VStack {
            List(self.fetchedFriends, id:\.wrappedId) {
                item in
                Text(item.wrappedName)
            }
        }
    }
}

struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        FriendListView(friendIds: ["a1ef63f3-0eab-49a8-a13a-e538f6d1c4f9"])
    }
}
