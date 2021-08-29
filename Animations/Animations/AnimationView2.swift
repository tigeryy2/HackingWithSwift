//
//  AnimationView2.swift
//  Animations
//
//  Created by Tiger Yang on 8/28/21.
//

import SwiftUI

struct AnimationView2: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        Button("Tap Me") {
            withAnimation(.easeInOut(duration: 1)) {
                self.animationAmount += 360
            }
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0.5, y: 1.0, z: 0.5)
        )
    }
}

struct AnimationView2_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView2()
    }
}
