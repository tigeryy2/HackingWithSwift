//
//  ExampleView8.swift
//  Examples
//
//  Created by Tiger Yang on 10/2/21.
//

import SwiftUI

struct ExampleView8: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: self.$selectedTab) {
            NavigationView {
                // tabview should encapsulate any navigationviews, as necessary..
                Text("Hello, World! tab: \(selectedTab)")
            }
            .tabItem {
                Image(systemName: "star")
                Text("1")
            }
            // strings are recommended here as tags instead of numbers
            .tag(0)
            NavigationView {
                Text("Goodbye, world ;( tab: \(selectedTab)")
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("2")
            }
            .tag(1)
            NavigationView {
                Text("Where are my tabs?? tab: \(selectedTab)")
            }
            .tabItem {
                Image(systemName: "globe")
                Text("3")
            }
            .tag(2)
        }
    }
}

struct ExampleView8_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView8()
    }
}
