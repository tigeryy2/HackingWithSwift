//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Tiger Yang on 8/21/21.
//

import SwiftUI

struct ContentView: View {
    @State private var backGroundIsRed: Bool = false
    
    private var howdyWorldTextView: some View = Text("Howdy, World")
    
    var body: some View {
        
        VStack {
            // to get background (and the color as a result) to fit over everything.. must frame the text view
            Text("Hello, world!")
                // note that order here matters...
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backGroundIsRed ? Color.red : Color.green)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
            Text("goodbye world")
                .padding()
                .background(Color.blue)
                .padding()
                .background(Color.green)
                .padding()
                .background(Color.red)
            
            howdyWorldTextView
                .blueTitleStyle()
            
            CapsuleTextView(text: "Nevermind")
        }
        // font is environment modifier, applies to all views in side this one
        // environ mods do no override child modifiers
        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        // however, some modifiers are only regular, and do not get overwritten, but both are added
        // an example is the "blur" modifier
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
