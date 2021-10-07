//
//  ContentView.swift
//  Flashzilla
//
//  Created by Tiger Yang on 10/5/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    /// True if the app is not in the background
    @State private var appIsActive = true
    @State private var cards = [Card](repeating: Card.example, count: 10)
    @State private var timeRemaining = 100
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                    )
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: self.cards[index]) {
                            withAnimation {
                                self.removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: self.cards.count)
                    }
                }
                // when time expires... do not allow swiping on the cards
                .allowsHitTesting(self.timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            if differentiateWithoutColor {
                VStack {
                    Spacer()
                    
                    HStack {
                        Image(systemName: "xmark.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                        Spacer()
                        Image(systemName: "checkmark.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(self.timer) { time in
            // do no count down if app is in the background...
            guard self.appIsActive else { return }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) {
            _ in
            self.appIsActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) {
            _ in
            if self.cards.isEmpty == false {
                self.appIsActive = true
            }
        }
    }
    
    /// Removes the  item at index in the cards array
    func removeCard(at index: Int) {
        // freeze timer if last card is checked
        if cards.isEmpty {
            self.appIsActive = false
        }
        
        self.cards.remove(at: index)
    }
    
    /// Replaces the cards and resets timer
    func resetCards() {
        cards = [Card](repeating: Card.example, count: 10)
        timeRemaining = 100
        self.appIsActive = true
    }
}

extension View {
    /// Offsets view by certain amount, used to stack views with some offset
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            ContentView()
                .previewInterfaceOrientation(.landscapeLeft)
        } else {
            ContentView()
        }
    }
}
