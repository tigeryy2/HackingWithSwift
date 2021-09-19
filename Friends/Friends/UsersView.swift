//
//  UserView.swift
//  Friends
//
//  Created by Tiger Yang on 9/17/21.
//

import SwiftUI
import CoreData

struct UsersView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserEntity.age, ascending: true)],
        animation: .default)
    private var fetchedUsers: FetchedResults<UserEntity>
    
    //@State private var users: [User] = [User]()
    
    var body: some View {
        FilteredList(
            filterKey: "name",
            filterValue: "T",
            predicate: .beginsWithNoCase,
            sortDescriptors: [NSSortDescriptor(keyPath: \UserEntity.name, ascending: true)]) {
            (user: UserEntity) in
            NavigationLink(destination: Text("Hi")) {
                VStack {
                    HStack {
                        Text("\(user.wrappedName),")
                            .font(.title2)
                        Text("\(user.age)")
                            .font(.title3)
                        Spacer()
                    }
                    
                    HStack {
                        Text(user.wrappedEmail)
                        Spacer()
                    }
                }
            }
        }
        .navigationBarTitle(Text("Users"))
    }
    
}


struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UsersView()
        }
    }
}
