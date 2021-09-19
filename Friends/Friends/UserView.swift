//
//  UserView.swift
//  Friends
//
//  Created by Tiger Yang on 9/17/21.
//

import SwiftUI

struct UserView: View {
    let user: User
    let users: [User]
    let friends: [User]
    
    init(user: User, users: [User]) {
        self.user = user
        self.users = users
        
        // matches id for friends of this user, to id in users
        var friendMatches = [User]()
        
        // for each friend, find the coresponding user
        for friend in user.friends {
            // look for first id match
            if let match = users.first(where: { $0.id == friend.id}) {
                friendMatches.append(match)
            } else {
                fatalError("Imaginary friends not allowed... could not find matching user id for friend")
            }
        }
        
        self.friends = users
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(user.name),")
                    .font(.largeTitle)
                    .bold()
                Text("\(user.age)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            
            Text(user.about)
                .padding()
            
            Spacer()
            List(self.friends, id:\.id) {
                friend in
                NavigationLink(
                    destination: UserView(user: friend, users: users),
                    label: {
                        Text(friend.name)
                    })
            }
            
            Spacer()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(
            user: User(id: "someId", isActive: true, name: "Tiger Yang", age: 23, company: "SiLabs", email: "goodtry@obviouslyGmail.com", address: "420 Somewhere Dr. Probably Austin, TX 77777", about: "write me a biography", registered: "1998-02-11", tags: ["meat"], friends: [User.Friend(id: "someId2", name: "hmmm...."), User.Friend(id: "someId3", name: "lmao....")]),
            users: [User(id: "someId2", isActive: true, name: "friend1", age: 23, company: "someFirm", email: "nah@gmail.com", address: "777 Overthere Dr.", about: "some random info here", registered: "1997-12-12", tags: ["a tag"], friends: [User.Friend(id: "someId4", name: "nah")])])
    }
}
