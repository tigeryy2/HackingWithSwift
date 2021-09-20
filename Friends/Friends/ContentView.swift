//
//  ContentView.swift
//  Friends
//
//  Created by Tiger Yang on 9/17/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // sort by age
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserEntity.age, ascending: true)],
        animation: .default)
    private var users: FetchedResults<UserEntity>
    
    // pattern for the filter predicate "search"
    @State private var searchString: String = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                // User Search Bar
                TextField("Search", text: self.$searchString)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 5.0)
                            .stroke()
                            .foregroundColor(.secondary)
                            .opacity(0.5)
                    )
                    .shadow(radius: 5)
                
                UsersView(searchString: self.$searchString)
                    .onAppear(perform: {
                        // load/reload users to coredata from json on every app load
                        // duplicates will be merged by coredata
                        self.loadUsersFromJson()
                    })
            }
        }
        
    }
    
    private func addItem() {
        withAnimation {
            let newItem = UserEntity(context: viewContext)
            newItem.name = "somePerson"
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { users[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func loadUsersFromJson() {
        // loads users from json into CoreData
        User.loadUsers(saveUsers: {
            (decodedUsers: [User]) in
            self.saveUsers(users: decodedUsers)
        })
    }
    
    private func saveUsers(users: [User]) {
        // saves the provided list of users to coredata
        for user in users {
            // for each user in the decoded json struct, save each attribute to the coredata entity
            let newUser = UserEntity(context: viewContext)
            newUser.about = user.about
            newUser.address = user.address
            newUser.age = Int16(user.age)
            newUser.name = user.name
            newUser.company = user.company
            newUser.email = user.email
            newUser.id = user.id
            newUser.isActive = user.isActive
            newUser.name = user.name
            newUser.registered = user.registered
            
            for friend in user.friends {
                let newFriend = FriendEntity(context: viewContext)
                newFriend.id = friend.id
                newFriend.name = friend.name
                
                // link to user entity
                newUser.addToFriends(newFriend)
            }
        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
