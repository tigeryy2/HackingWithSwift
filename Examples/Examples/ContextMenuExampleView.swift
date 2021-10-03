//
//  ContextMenuExampleView.swift
//  Examples
//
//  Created by Tiger Yang on 10/3/21.
//

import SwiftUI

struct ContextMenuExampleView: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(action: {
                        self.backgroundColor = .red
                    }) {
                        Text("Red")
                        Image(systemName: "globe")
                    }
                    
                    Button(action: {
                        self.backgroundColor = .green
                    }) {
                        Text("Green")
                    }
                    
                    Button(action: {
                        self.backgroundColor = .blue
                    }) {
                        Text("Blue")
                    }
                }
        }
    }
}

struct ContextMenuExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuExampleView()
    }
}
