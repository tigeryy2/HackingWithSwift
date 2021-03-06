//
//  NumberButton.swift
//  MultiplicationMadness
//
//  Created by Tiger Yang on 9/4/21.
//

import SwiftUI

struct NumberButton: View {
    let buttonText: String
    @Binding var buttonColor: Color
    
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .stroke(buttonColor, lineWidth: 5)
                .frame(maxWidth: 200, maxHeight: 100)
                .shadow(radius: 5)
                .overlay(
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .stroke(buttonColor)
                        .scaleEffect(((animationAmount - 1) / 4) + 1)
                        .opacity(Double(2 - animationAmount))
                        .animation(
                            Animation.easeOut(duration: 2)
                                .repeatForever(autoreverses: false)
                        )
                )
                .onAppear {
                    self.animationAmount = 2
                }
            Text(buttonText)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.primary)
        }
            
    }
}

struct NumberButton_Previews: PreviewProvider {
    @State static private var buttonColor = Color.green
    static var previews: some View {
        NumberButton(buttonText: "12", buttonColor: self.$buttonColor)
    }
}
