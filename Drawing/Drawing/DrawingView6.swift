//
//  DrawingView6.swift
//  Drawing
//
//  Created by Tiger Yang on 9/9/21.
//

import SwiftUI

struct DrawingView6: View {
    @State private var amount: CGFloat = 0.5
    @State private var blendMode: BlendMode = .screen
    
    var blendModeOptions: [BlendMode] = [.multiply, .screen, .colorBurn, .difference, .exclusion]
    var blendModeText: [String] = ["multiply", "screen", "colorburn", "difference", "exclusion"]
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .frame(width: 400, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(y: -50)
                    .opacity((blendMode == .multiply || blendMode == .colorBurn) ? 1 : 0)
                    .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/(duration: 2))
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 200 * amount)
                    .offset(x: -50, y: -80)
                    .blendMode(self.blendMode)
                    .animation(.easeInOut(duration: 2))
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 200 * amount)
                    .offset(x: 50, y: -80)
                    .blendMode(self.blendMode)
                    .animation(.easeInOut(duration: 2))
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 200 * amount)
                    .blendMode(self.blendMode)
                    .animation(.easeInOut(duration: 2))
                
            }
            .frame(width: 300, height: 300)
            
            Slider(value: $amount)
                .padding()
            
            Picker(selection: self.$blendMode, label: Text("Blendmode"), content: {
                ForEach(Array(blendModeOptions.enumerated()), id:\.element) {
                    index, element in
                    Text("\(blendModeText[index])")
                        .foregroundColor(.white)
                }
            })
            
            Image("IMG_3411")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(Double(amount))
                .blur(radius: (1 - amount) * 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct DrawingView6_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView6()
    }
}
