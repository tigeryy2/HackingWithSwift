//
//  UserView.swift
//  Friends
//
//  Created by Tiger Yang on 9/17/21.
//

import SwiftUI

struct UsersView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserEntity.age, ascending: true)],
        animation: .default)
    private var fetchedUsers: FetchedResults<UserEntity>
    
    @State private var users: [User] = [User]()
    
    var body: some View {
        List(self.users, id:\.id) {
            user in
//            FilteredList(
//                filterKey: "name",
//                filterValue: "T",
//                predicate: .beginsWithNoCase,
//                sortDescriptors: [NSSortDescriptor(keyPath: \UserEntity.name, ascending: true)]) {
//                (user: UserEntity) in
                NavigationLink(destination: UserView(user: user, users: users)) {
                    VStack {
                        HStack {
                            Text("\(user.name),")
                                .font(.title2)
                            Text("\(user.age)")
                                .font(.title3)
                            Spacer()
                        }
                        
                        HStack {
                            Text(user.email)
                            Spacer()
                        }
                    }
                }
            //}
        }
        .navigationBarTitle(Text("Users"))
        .onAppear(perform: {
                    User.loadUsers(saveUsers: {
                        (decodedData: [User]) in
                        self.users = decodedData
                    })
        })
    }
    
}


struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UsersView()
        }
    }
}
