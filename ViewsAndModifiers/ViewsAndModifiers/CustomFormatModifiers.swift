//
//  CustomFormatModifiers.swift
//  ViewsAndModifiers
//
//  Created by Tiger Yang on 8/21/21.
//

import SwiftUI
import Foundation

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

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    func blueTitleStyle() -> some View {
        self.modifier(BlueTitle())
    }
}
