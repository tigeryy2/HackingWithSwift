//
//  ScrollViewEffectExampleView.swift
//  LayoutAndGeometry
//
//  Created by Tiger Yang on 10/9/21.
//

import SwiftUI

struct ScrollViewEffectExampleView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(width: fullView.size.width)
                            .background(self.colors[index % 7])
                            .shadow(color: .gray, radius: 5)
                            .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5), axis: (x: 0, y: 1, z: 0))

                    }
                    .frame(height: 40)
                }
            }
            .animation(.easeInOut)
        }
    }
}

struct ScrollViewEffectExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewEffectExampleView()
    }
}
