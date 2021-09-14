//
//  ExampleView4.swift
//  Examples
//
//  Created by Tiger Yang on 9/13/21.
//

import SwiftUI

struct ExampleView4: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .compact {
            // uses type erasure (anyview) so that both cases we get the same view type
            return AnyView(VStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle))
        }
    }
}

struct ExampleView4_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView4()
    }
}
