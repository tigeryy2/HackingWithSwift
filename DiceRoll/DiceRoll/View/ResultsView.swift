//
//  ResultsView.swift
//  DiceRoll
//
//  Created by Tiger Yang on 10/10/21.
//

import SwiftUI

struct ResultsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Roll.time, ascending: false)],  animation: .default) private var rollResults: FetchedResults<Roll>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rollResults) {
                    rollResult in
                    HStack {
                        Text("\(rollResult.result)")
                            .font(.title)
                            .foregroundColor(getRollColor(roll: rollResult))
                        
                        Spacer()
                        
                        HStack {
                            // x Dice
                            Text("\(rollResult.numberOfDice)")
                            Image(systemName: "dice.fill")
                            
                            // x sides
                            Text("\(rollResult.numberOfSides)")
                            Image(systemName: "questionmark.square.fill")
                        }
                        .font(.title2)
                    }
                }
                .onDelete(perform: deleteRollResult)
            }
            .navigationTitle(Text("Roll Results"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    // Delete all results
                    Button(action: {
                        deleteRollResult(offsets: IndexSet(integersIn: 0..<rollResults.endIndex))
                    }) {
                        Text("Clear All")
                    }
                }
            }
        }
    }
    
    private func getRollColor(roll: Roll) -> Color {
        let maxPossible = roll.numberOfSides * roll.numberOfDice
        
        // upper bounds for middle and lower thirds
        let middleThird = maxPossible * 2/3
        let lowerThird = maxPossible * 1/3
        
        if roll.result <= lowerThird {
            return .red
        } else if roll.result <= middleThird {
            return .yellow
        } else {
            return .green
        }
    }
    
    private func deleteRollResult(offsets: IndexSet) {
        withAnimation {
            offsets.map { rollResults[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
