//
//  UserView.swift
//  Friends
//
//  Created by Tiger Yang on 9/17/21.
//

import SwiftUI

struct UserView: View {
    let user: User
    
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
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(id: "someId", isActive: true, name: "Tiger Yang", age: 23, company: "SiLabs", email: "goodtry@obviouslyGmail.com", address: "420 Somewhere Dr. Probably Austin, TX 77777", about: "write me a biography", registered: "1998-02-11", tags: ["meat"], friends: [User.Friend(id: "someId2", name: "hmmm...."), User.Friend(id: "someId3", name: "lmao....")]))
    }
}
