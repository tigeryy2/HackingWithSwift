//
//  AddHabitView.swift
//  Habits
//
//  Created by Tiger Yang on 9/10/21.
//

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var habits: Habits
    
    // links to the view's environment, the "isPresented" from the parent
    @Environment(\.presentationMode) var presentationMode
    
    @State private var habitName: String = ""
    @State private var description: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $habitName)
                TextEditorWithPlaceholderView(textEditorText: self.$description, defaultText: "Description")
            }
            .navigationBarTitle(Text("Add Habit"))
            .navigationBarItems(trailing: Button("Save") {
                if self.habitName.isEmpty {
                    // name is empty..
                } else if self.description.isEmpty {
                    // description is empty...
                } else {
                    self.habits.habits.append(Habit(
                        id: UUID(),
                        name: self.habitName,
                        description: self.description,
                        completedCount: 0.0
                    ))
                    
                    // hide sheet after adding the habit
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    @StateObject static var habits: Habits = Habits()
    
    static var previews: some View {
        AddHabitView(habits: self.habits)
    }
}
