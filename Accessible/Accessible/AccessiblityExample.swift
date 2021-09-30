//
//  AccessiblityExample.swift
//  Accessible
//
//  Created by Tiger Yang on 9/30/21.
//

import SwiftUI

struct AccessiblityExample: View {
    @State private var estimate = 25.0
    
    var body: some View {
        Slider(value: $estimate, in: 0...50)
            .accessibilityValue(Text("\(Int(estimate))"))
            .padding()
    }
}

struct AccessiblityExample_Previews: PreviewProvider {
    static var previews: some View {
        AccessiblityExample()
    }
}
