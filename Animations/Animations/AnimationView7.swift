//
//  AnimationView7.swift
//  Animations
//
//  Created by Tiger Yang on 8/29/21.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct AnimationView7: View {
    @State private var isShowingRectangle: Bool = false

    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation(.easeInOut) {
                    self.isShowingRectangle.toggle()
                }
            }
            
            if isShowingRectangle {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
            
    }
}

struct AnimationView7_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView7()
    }
}
