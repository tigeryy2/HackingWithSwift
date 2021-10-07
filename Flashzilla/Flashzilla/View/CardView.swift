//
//  CardView.swift
//  Flashzilla
//
//  Created by Tiger Yang on 10/6/21.
//

import SwiftUI

struct CardView: View {
    /// Drag offset of the card
    @State private var offset = CGSize.zero
    @State private var isShowingAnswer = false
    
    let card: Card
    
    var removeCard: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 10)
            
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .onTapGesture {
                        withAnimation {
                            self.isShowingAnswer.toggle()
                        }
                    }
                if self.isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 3, y: 0)
        .opacity(1.5 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }
            
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        self.removeCard?()
                    } else {
                        self.offset = .zero
                    }
                }
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            CardView(card: Card.example)
                .previewInterfaceOrientation(.landscapeLeft)
        } else {
            CardView(card: Card.example)
        }
    }
}