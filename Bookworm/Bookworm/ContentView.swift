//
//  ContentView.swift
//  Bookworm
//
//  Created by Tiger Yang on 9/13/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showingAddBookScreen = false
    
    // can add multiple sort descriptors, swift will use the first one first, then others as needed to decide ties
    @FetchRequest(
        entity: Book.entity(),
        sortDescriptors:
            [NSSortDescriptor(keyPath: \Book.title, ascending: true),
             NSSortDescriptor(keyPath: \Book.author, ascending: true)])
    private var books: FetchedResults<Book>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id:\.self) {
                    book in
                    NavigationLink(
                        destination: DetailView(book: book),
                        label: {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack {
                                Text(book.title ?? "meh")
                                    .font(.headline)
                                Text(book.author ?? "nah")
                                    .foregroundColor(.secondary)
                            }
                        })
                }
                .onDelete(perform: self.deleteBooks)
            }
            .navigationBarTitle("Bookworm")
            .navigationBarItems(trailing:
                                    HStack {
                                        EditButton()
                                        Button(action: {
                                            self.showingAddBookScreen.toggle()
                                        }) {
                                            Image(systemName: "plus")
                                                .font(.title2)
                                        }
                                    })
            .sheet(isPresented: $showingAddBookScreen) {
                // since a sheet does not have the presented view as an "ancestor", need to manually add our viewcontext to the sheet's environment
                AddBookView().environment(\.managedObjectContext, self.viewContext)
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            //let newItem = Book(context: viewContext)
            //newItem.timestamp = Date()
            
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
    
    private func deleteBooks(offsets: IndexSet) {
        withAnimation {
            offsets.map { books[$0] }.forEach(viewContext.delete)
            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
