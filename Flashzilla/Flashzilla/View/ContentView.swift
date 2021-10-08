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
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    /// True if the app is not in the background
    @State private var appIsActive = true
    @State private var cards = [Card]()
    @State private var showingEditCardScreen = false
    @State private var timeRemaining = 100
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // decorative images are not read by voiceover
            Image(decorative: "IMG_9346")
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
                        // allow only top card to be dragged
                        .allowsHitTesting(index == self.cards.count - 1)
                        // read only top card for voiceover
                        .accessibility(hidden: index < self.cards.count - 1)
                    }
                }
                // when time expires... do not allow swiping on the cards
                .allowsHitTesting(self.timeRemaining > 0)
                
                if self.cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        self.showingEditCardScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                //Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if self.differentiateWithoutColor || self.accessibilityEnabled {
                // for low color mode, allow use of buttons that also indicate the side for correct/incorrect
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            self.removeCard(at: self.cards.count - 1)
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel(Text("Incorrect"))
                        .accessibilityHint(Text("Mark your answer as incorrect"))
                        
                        Spacer()
                        Button(action: {
                            self.removeCard(at: self.cards.count - 1)
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel(Text("Correct"))
                        .accessibilityHint(Text("Mark your answer as correct"))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showingEditCardScreen, onDismiss: resetCards) {
            EditCardsView()
        }
        .onReceive(self.timer) { time in
            // do no count down if app is in the background...
            guard self.appIsActive else { return }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .onAppear(perform: resetCards)
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
    
    /// Load cards from userdefaults
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    /// Removes the  item at index in the cards array
    func removeCard(at index: Int) {
        // make sure we have cards to remove...
        guard index >= 0 else { return }
        
        // freeze timer if last card is checked
        if cards.isEmpty {
            self.appIsActive = false
        }
        
        self.cards.remove(at: index)
    }
    
    /// Replaces the cards and resets timer
    func resetCards() {
        timeRemaining = 100
        self.appIsActive = true
        loadData()
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
