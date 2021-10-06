//
//  AccessibilityExampleView.swift
//  Examples
//
//  Created by Tiger Yang on 10/6/21.
//

import SwiftUI

struct AccessibilityExampleView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? Color.black : Color.green)
        .foregroundColor(Color.white)
        .clipShape(Capsule())
    }
}

struct AccessibilityExampleView_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityExampleView()
    }
}
