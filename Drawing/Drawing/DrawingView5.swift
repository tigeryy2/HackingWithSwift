//
//  DrawingView5.swift
//  Drawing
//
//  Created by Tiger Yang on 9/9/21.
//

import SwiftUI

struct DrawingView5: View {
    var body: some View {
        ZStack {
            Image("IMG_3411")

            Rectangle()
                .fill(Color.red)
                .blendMode(.multiply)
        }
        .frame(width: 400, height: 500)
        .clipped()
    }
}

struct DrawingView5_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView5()
    }
}
