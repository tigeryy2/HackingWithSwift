//
//  ExampleView5.swift
//  Examples
//
//  Created by Tiger Yang on 9/21/21.
//

import SwiftUI

struct ExampleView5: View {
    @State private var blurAmount: CGFloat = 0
    
    var body: some View {
        // custom binding
        // cannot directly do a didset,willset on a State variable, as the state struct wrapper itself is not changing
        let blur = Binding<CGFloat>(
            get: {
                // getter returns some value
                self.blurAmount
            },
            set: {
                // setter sets some value
                // and can call other code...
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )
        
        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
            
            Slider(value: blur, in: 0...20)
        }
    }
}

struct ExampleView5_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView5()
    }
}
