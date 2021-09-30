//
//  AccessibilityExample2.swift
//  Accessible
//
//  Created by Tiger Yang on 9/30/21.
//

import SwiftUI

struct AccessibilityExample2: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let pictureLabels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    var body: some View {
        VStack {
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }
            // do not read the items inside
            .accessibilityElement(children: .ignore)
            // instead use this label..
            .accessibilityLabel(Text("Your score is 1000"))
            
            Image(pictures[selectedPicture])
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    self.selectedPicture = Int.random(in: 0...3)
                }
            // tell voiceover what the image is, that it's a button, and to not bother saying it's an image
                .accessibilityLabel( Text(self.pictureLabels[self.selectedPicture]))
                .accessibilityAddTraits(.isButton)
                .accessibilityRemoveTraits(.isImage)
        }
    }
}

struct AccessibilityExample2_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityExample2()
    }
}
