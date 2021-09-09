//
//  DrawingView.swift
//  Drawing
//
//  Created by Tiger Yang on 9/8/21.
//

import SwiftUI

struct Arc: Shape, InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: (rect.width / 2) - self.insetAmount,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )

        return path
    }
    
    // allows use of strokeBorder
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ArcCorrected: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    
    func path(in rect: CGRect) -> Path {
        // 0 degress now directly down
        let rotationAdjustment = Angle.degrees(90)
        let adjustedStartAngle: Angle = self.startAngle - rotationAdjustment
        let adjustedEndAngle: Angle = self.endAngle - rotationAdjustment
        let adjustedClockwise: Bool = !self.clockwise
        
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2,
            startAngle: adjustedStartAngle,
            endAngle: adjustedEndAngle,
            clockwise: adjustedClockwise
        )

        return path
    }
}

struct DrawingView: View {
    var body: some View {
        
        VStack {
            // 0 degress is pointing directly to the right
            // 0, 0 is the bottom left corner
            Arc(
                startAngle: .degrees(0),
                endAngle: .degrees(110),
                clockwise: true
            )
                .strokeBorder(Color.blue, lineWidth: 10)
                .frame(width: 300, height: 300)
            
            Spacer()
            
            ArcCorrected(
                startAngle: .degrees(0),
                endAngle: .degrees(110),
                clockwise: true)
                .stroke(Color.blue, lineWidth: 10)
                .frame(width: 300, height: 300)
        }

    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
