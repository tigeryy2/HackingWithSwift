//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Tiger Yang on 10/8/21.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        VStack {
            Text("Howdy Fam")
                .background(Color.red)
                .position(x: 100, y: 100)
                .background(Color.blue)
            
            Text("Offsets...")
                .offset(x: 100, y: 0)
                .background(Color.orange)
            
            Text("Offsets last...")
                .background(Color.green)
                .offset(x: -100)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
