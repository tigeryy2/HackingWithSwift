//
//  HabitsView.swift
//  Habits
//
//  Created by Tiger Yang on 9/10/21.
//

import SwiftUI

struct HabitsView: View {
    @StateObject var habits: Habits = Habits()
    @State private var showingAddHabit = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(self.habits.habits.enumerated()), id:\.element) { index, habit in
                    NavigationLink(destination: HabitView(habits: self.habits, index: index)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(habit.name)
                                    .font(.headline)
                                Text("\(self.habits.habits[index].completedCount, specifier: "%.0f")")
                            }
                            
                            Spacer()
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle(Text("Habits"))
            .navigationBarItems(trailing: HStack {
                EditButton()
                Button(action: {
                    self.showingAddHabit = true
                }) {
                    Image(systemName: "plus")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
            })
        }
        .sheet(isPresented: self.$showingAddHabit) {
            AddHabitView(habits: self.habits)
        }
    }
    
    func removeItems(at offsetts: IndexSet) {
        self.habits.habits.remove(atOffsets: offsetts)
    }
    
}

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView()
    }
}
