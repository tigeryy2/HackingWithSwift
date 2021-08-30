//
//  AnimationView3.swift
//  Animations
//
//  Created by Tiger Yang on 8/29/21.
//

import SwiftUI

struct AnimationView3: View {
    @State private var enabled = false
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Tap Me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.red : Color.orange)
        .foregroundColor(.white)
        .animation(.default)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 5, damping: 10))
        .overlay(
            RoundedRectangle(cornerRadius: enabled ? 60 : 0)
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeInOut(duration: 2)
                        .repeatForever(autoreverses: false)
                )
        )
        .onAppear {
            self.animationAmount = 2
        }

    }
}

struct AnimationView3_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView3()
    }
}
