//
//  ContentView.swift
//  PhotoBook
//
//  Created by Tiger Yang on 10/1/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Photo.name, ascending: true)],
        animation: .default)
    private var photos: FetchedResults<Photo>
    
    @State private var chosenImage: UIImage?
    @State private var showingAddPhoto = false
    @State private var showingImagePicker = false
    
    init() {
        let fullFilename = ContentView.getDocumentsDirectory()
            .appendingPathComponent("placeholder")
        
        // if placeholder image is not already saved to disk, save it
        if !(FileManager.default.fileExists(atPath: fullFilename.path)) {
            let image = UIImage(named: "placeholder")!
            AddPhotoView.savePhotoToDisk(image, as: "placeholder")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(photos) { photo in
                    NavigationLink {
                        PhotoDetailView(photo: photo)
                    } label: {
                        HStack {
                            Image(uiImage: photo.getUIImage())
                                .resizable()
                                .frame(maxWidth: 150, maxHeight: 150)
                                .clipShape(Circle())
                                .overlay(Circle().stroke().foregroundColor(.gray))
                            VStack(alignment: .leading) {
                                Text(photo.wrappedName)
                                    .font(.headline)
                                Text(photo.wrappedInfo)
                                    .font(.body)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .sheet(isPresented: self.$showingAddPhoto) {
                AddPhotoView(image: self.$chosenImage)
            }
            .sheet(isPresented: self.$showingImagePicker,
                   onDismiss: self.addPhoto) {
                ImagePicker(image: self.$chosenImage)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    // + button triggers choose photo sheet
                    Button(action: self.choosePhoto) {
                        Label("Add Photo", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    /// Creates new Photo entity and triggers interface to modify attributes, and saves photo to disk
    private func addPhoto() {
        self.showingAddPhoto = true
    }
    
    /// Trigger image picker sheet
    private func choosePhoto() {
        // trigger imagepicker sheet to show
        self.showingImagePicker = true
    }
    
    /// Standard function to return the current app's documents directory
    public static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

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

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { photos[$0] }.forEach(viewContext.delete)

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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
