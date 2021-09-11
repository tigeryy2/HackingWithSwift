//
//  ExampleView1.swift
//  Examples
//
//  Created by Tiger Yang on 9/11/21.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ExampleView1: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // runs when the data task completes, on the background thread
            
            // best not to mess w/ our UI properties in a background thread... so we send it to the main thread queue.
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.results = decodedResponse.results
                    }
                    
                    // everything is good, so we can exit
                    return
                }
            }
            
            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
        // resume tells the task to run in background. Our app will continue running
    }
}


struct ExampleView1_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView1()
    }
}
