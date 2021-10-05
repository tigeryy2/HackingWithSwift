//
//  ContentView.swift
//  HotProspects
//
//  Created by Tiger Yang on 10/2/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    /// Determines how to sort prospects
    @State private var sortFilter: SortFilterType = .nameAlphabetical
    
    // load prospects from file, or empty array if cannot load
    var prospects: Prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(sortFilter: self.$sortFilter, filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            ProspectsView(sortFilter: self.$sortFilter, filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
                }
            ProspectsView(sortFilter: self.$sortFilter, filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
                }
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
        }
        // places this into environment of all child views
        .environmentObject(self.prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
