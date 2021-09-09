//
//  DrawingView3.swift
//  Drawing
//
//  Created by Tiger Yang on 9/8/21.
//

import SwiftUI

struct DrawingView3: View {
    var body: some View {
        VStack {
            
            Text("lol, world")
                .frame(width: 150, height: 150)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 5)
                .padding()
            
            Text("lol, world")
                .frame(width: 150, height: 150)
                .background(
                    Image("IMG_3411")
                        .resizable()
                        .frame(width: 150, height: 150))
                .padding()
            
            // cannot directly use image as a border...
            // imagepaint allows us to manipulate images in any way and then use them in borders, etc
            Text("Hello World")
                .frame(width: 150, height: 150)
                .border(ImagePaint(image: Image("IMG_3411"), scale: 0.2), width: 30)
                .padding()
            
            Text("Hello World")
                .frame(width: 150, height: 150)
                .border(ImagePaint(image: Image("IMG_3411"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
            
            Capsule()
                .strokeBorder(ImagePaint(image: Image("IMG_3411"), scale: 0.1), lineWidth: 20)
                .frame(width: 150, height: 100)
        }
    }
}

struct DrawingView3_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView3()
    }
}
