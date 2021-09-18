//
//  UserView.swift
//  Friends
//
//  Created by Tiger Yang on 9/17/21.
//

import SwiftUI

struct UsersView: View {
    @State private var users: [User] = [User]()
    
    var body: some View {
        List(self.users, id:\.id) {
            user in
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
