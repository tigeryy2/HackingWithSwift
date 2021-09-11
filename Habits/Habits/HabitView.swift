//
//  HabitView.swift
//  Habits
//
//  Created by Tiger Yang on 9/10/21.
//

import SwiftUI

struct HabitView: View {
    @ObservedObject var habits: Habits
    let index: Int
        
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(self.habits.habits[index].name)
                    .font(.largeTitle)
                ScrollView(.vertical) {
                    HStack {
                        Text(self.habits.habits[index].description)
                        Spacer()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 4)
                
                Text("Current Completions: \(self.habits.habits[index].completedCount)")
                Button(action: {
                    // replace habit struct in given index with new one, that has the completions incremented
                    self.habits.habits[index].completedCount += 1
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 100))
                        .padding()
                }
            }
        }
    }
}

struct HabitView_Previews: PreviewProvider {
    @StateObject static var habits: Habits = Habits()
    
    static var previews: some View {
        HabitView(habits: self.habits, index: 0)
    }
}
