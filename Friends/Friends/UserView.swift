//
//  UserView.swift
//  Friends
//
//  Created by Tiger Yang on 9/17/21.
//

import SwiftUI
import CoreData

struct UserView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserEntity.age, ascending: true)],
        animation: .default)
    private var fetchedUsers: FetchedResults<UserEntity>
        
    let user: UserEntity
    var friendIds: [String]
    
    init(user: UserEntity) {
        self.user = user
        
        // accumulate list of user IDs for the friends, so we can filter for friends only
        self.friendIds = [String]()
        for friend in user.friendArray {
            friendIds.append(friend.wrappedId)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(user.wrappedName),")
                    .font(.largeTitle)
                    .bold()
                Text("\(user.age)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            
            Text(user.wrappedAbout)
                .padding()
            
            Spacer()
            
            HStack {
                Text("Friends")
                    .font(.title2)
                Spacer()
            }
            .padding()
            
            // filtered list, that filters for friend ID list
            FriendListView(friendIds: self.friendIds)
            
            Spacer()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    // can create a static managed object context just for the preview
    static let previewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        UserView(user: UserEntity(context: previewContext))
    }
}
