//
//  DrawingView9.swift
//  Drawing
//
//  Created by Tiger Yang on 9/9/21.
//

import SwiftUI

struct ArrowView: View {
    var arrowWidth: CGFloat
    var lineWidth: CGFloat
    
    public var animatableData: CGFloat {
        get {
            self.lineWidth
        }
        
        set {
            self.lineWidth = newValue
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Triangle()
                    .frame(width: self.arrowWidth, height: geometry.size.height / 2)
                    .offset(x: (geometry.size.width / 2) - (self.arrowWidth / 2))
                Rectangle()
                    .frame(width: self.lineWidth, height: geometry.size.height / 2)
                    .offset(x: (geometry.size.width / 2) - (self.arrowWidth / 2), y: geometry.size.height / 2)
            }
        }
    }
}

struct ChallengeView1: View {
    @State private var animationAmount: CGFloat = 100
        
    var body: some View {
        VStack {
            ArrowView(arrowWidth: animationAmount * 2, lineWidth: animationAmount)
            
            Slider(value: $animationAmount, in: 1 ... 300)
                .padding()
        }
        .animation(.spring(blendDuration: 2))
        
    }
}

struct DrawingView9_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView1()
    }
}
