//
//  AnimationView6.swift
//  Animations
//
//  Created by Tiger Yang on 8/29/21.
//

import SwiftUI

struct AnimationView6: View {
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
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
            }
        }
}

struct AnimationView6_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView6()
    }
}
