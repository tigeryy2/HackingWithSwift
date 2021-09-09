//
//  DrawingView7.swift
//  Drawing
//
//  Created by Tiger Yang on 9/9/21.
//

import SwiftUI

// note that all shapes automatically conform to the Animatable property
struct Trapezoid: Shape {
    var insetAmount: CGFloat
    
    // by default, an empty struct is provided.
    // we can define our own, that contains data that can be animated
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct DrawingView7: View {
    @State private var insetAmount: CGFloat = 50
    
    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation(.easeIn(duration: 0.5)) {
                    self.insetAmount = CGFloat.random(in: 10...90)
                }
                
            }
    }
}

struct DrawingView7_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView7()
    }
}
