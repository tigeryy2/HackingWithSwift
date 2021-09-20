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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserEntity.age, ascending: true)],
        animation: .default)
    private var users: FetchedResults<UserEntity>
    
    var body: some View {
        NavigationView {
            UsersView()
                .onAppear(perform: {
                    self.loadUsersFromJson()
                })
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
