//
//  RpsButtonView.swift
//  RockPaperScissors
//
//  Created by Tiger Yang on 8/22/21.
//

import SwiftUI

struct RpsButtonView: View {
    var objectChoice: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(objectChoice)
                .font(.largeTitle)
                .frame(maxWidth: 200, maxHeight: 100)
                .background(Color.gray.opacity(0.25))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black.opacity(0.5), lineWidth: 0.5))
                .shadow(color: .black, radius: 1)
                
        }
        
    }
}

struct RpsButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RpsButtonView(objectChoice: "Rock") {
            print("Button was tapped!")
        }
    }
}
