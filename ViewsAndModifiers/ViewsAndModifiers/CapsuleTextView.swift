//
//  CapsuleTextView.swift
//  ViewsAndModifiers
//
//  Created by Tiger Yang on 8/21/21.
//

import SwiftUI

struct CapsuleTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            // using extended view function to apply custom modifier
            .titleStyle()
        
    }
}

struct CapsuleTextView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleTextView(text: "Hello World")
    }
}
