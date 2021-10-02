//
//  SwiftUIView.swift
//  PhotoBook
//
//  Created by Tiger Yang on 10/1/21.
//

import SwiftUI

struct AddPhotoView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Photo.name, ascending: true)],
        animation: .default)
    private var photos: FetchedResults<Photo>
    
    @State private var name: String = ""
    @State private var info: String = ""
    
    @Binding var image: UIImage?
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: self.$name)
                    TextField("Info", text: self.$info)
                }
                
                HStack {
                    Spacer()
                    if image != nil {
                        Image(uiImage: image!)
                            .resizable()
                            .frame(maxWidth: 250, maxHeight: 250)
                            .clipShape(Circle())
                            .overlay(Circle().stroke().foregroundColor(.gray))
                    } else {
                        Image("placeholder")
                            .resizable()
                            .frame(maxWidth: 250, maxHeight: 250)
                            .clipShape(Circle())
                            .overlay(Circle().stroke().foregroundColor(.gray))
                    }
                    Spacer()
                }
                
            }
            .navigationTitle(Text("Add Photo"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    Button(action: self.savePhoto) {
                        Text("Save")
                            .font(.title3)
                    }
            )
        }
    }
    
    /// Creates a Photo entity object, saves the data into Coredata, saves the photo to disk
    private func savePhoto() {
        withAnimation {
            let newPhoto = Photo(context: viewContext)
            newPhoto.id = UUID()
            newPhoto.name = self.name
            newPhoto.info = self.info
            newPhoto.filename = newPhoto.id?.uuidString
            newPhoto.timestamp = Date()
            
            Self.savePhotoToDisk(self.image!, as: newPhoto.filename!)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            // now that photo is saved, we can dismiss this view
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    /// Save a new photo our app directory
    public static func savePhotoToDisk(_ photo: UIImage, as filename: String) {
        do {
            let fullFilename = ContentView.getDocumentsDirectory()
            //.appendingPathComponent("SavedPhotos")
                .appendingPathComponent(filename)
            
            if let jpegData = photo.jpegData(compressionQuality: 0.8) {
                do {
                    try jpegData.write(to: fullFilename, options: [.atomicWrite, .completeFileProtection])
                } catch {
                    print("Unable to save photo")
                }
            }
        }
    }
}

struct AddPhotoView_Previews: PreviewProvider {
    @State static var image: UIImage?
    
    static var previews: some View {
        AddPhotoView(image: self.$image)
    }
}
