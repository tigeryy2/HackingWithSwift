//
//  CustomFormatModifiers.swift
//  ViewsAndModifiers
//
//  Created by Tiger Yang on 8/21/21.
//

import Foundation
import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.red)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}
