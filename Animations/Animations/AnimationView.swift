//
//  AnimationView.swift
//  Animations
//
//  Created by Tiger Yang on 8/28/21.
//

import SwiftUI

struct AnimationView: View {
    @State private var animationAmount: CGFloat = 1

       var body: some View {
           VStack {
               Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
                .padding()

               Spacer()

               Button("Tap Me") {
                   self.animationAmount += 1
               }
               .padding(40)
               .background(Color.red)
               .foregroundColor(.white)
               .clipShape(Circle())
               .scaleEffect(animationAmount)
           }
       }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}
