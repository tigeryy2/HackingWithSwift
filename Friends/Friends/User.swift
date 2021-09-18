//
//  Users.swift
//  Friends
//
//  Created by Tiger Yang on 9/17/21.
//

import Foundation

// mirrors json @ https://www.hackingwithswift.com/samples/friendface.json

struct User: Decodable {
    struct Friend: Decodable {
        let id: String
        let name: String
    }
    
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
    
    static func loadUsers(saveUsers: @escaping ([User]) -> Void) {
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
                        saveUsers(decodedResponse)
                        //self.users = decodedResponse
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


