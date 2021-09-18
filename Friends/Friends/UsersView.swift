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
            NavigationLink(destination: UserView(user: user)) {
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
        .onAppear(perform: loadUsers)
    }
    
    func loadUsers() {
        // force unwrap, as we know this url is valid
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        
        // trigger datatask on seperate thread, to request the json
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                // check that data was recieved
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.users = decodedResponse
                    }
                    
                    // everything is good, exit
                    return
                }
            }
            
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}


struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UsersView()
        }
    }
}
