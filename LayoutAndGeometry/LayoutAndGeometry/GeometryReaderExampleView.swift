//
//  GeometryReaderExampleView.swift
//  LayoutAndGeometry
//
//  Created by Tiger Yang on 10/9/21.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}

struct GeometryReaderExampleView: View {
    var body: some View {
        OuterView()
            .background(Color.red)
            .coordinateSpace(name: "Custom")
    }
}

struct GeometryReaderExampleView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderExampleView()
    }
}
