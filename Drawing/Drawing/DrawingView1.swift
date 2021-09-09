//
//  DrawingView1.swift
//  Drawing
//
//  Created by Tiger Yang on 9/8/21.
//

import SwiftUI

struct DrawingView1: View {
    var body: some View {
        HStack {
            // stroke has the wide stroke half inside the shape, half outside
            Circle()
                .stroke(Color.blue, lineWidth: 40)
            
            // stroke border draws the stroke strictly inside the shape border
            Circle()
                .strokeBorder(Color.blue, lineWidth: 40)
        }
    }
}

struct DrawingView1_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView1()
    }
}
