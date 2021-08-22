//
//  FlagView.swift
//  GuessTheFlag
//
//  Created by Tiger Yang on 8/21/21.
//

import SwiftUI

struct FlagView: View {
    var image: Image
    
    var body: some View {
        image
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth:  1))
            .shadow(color: .black,radius: 2)
    }
}

struct FlagView_Previews: PreviewProvider {
    static var previews: some View {
        FlagView(image: Image("Spain"))
    }
}
