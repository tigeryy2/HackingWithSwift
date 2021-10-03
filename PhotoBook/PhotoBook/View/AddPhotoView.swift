//
//  SwiftUIView.swift
//  PhotoBook
//
//  Created by Tiger Yang on 10/1/21.
//

import CoreLocation
import SwiftUI

struct AddPhotoView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Photo.name, ascending: true)],
        animation: .default)
    private var photos: FetchedResults<Photo>
    
    // Textfield state variables
    @State private var name: String = ""
    @State private var info: String = ""
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    
    // image picked for this photo
    @Binding var image: UIImage?
    
    let location: CLLocationCoordinate2D
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    TextField("Name", text: self.$name)
                    TextField("Info", text: self.$info)
                }
                
                // populate on startup with the current location.
                Section(header: Text("Location")) {
                    TextField("Latitude", text: self.$latitude)
                    TextField("Longitude", text: self.$longitude)
                }
                .keyboardType(.decimalPad)
                .onAppear() {
                    self.latitude = "\(location.latitude)"
                    self.longitude = "\(location.longitude)"
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
                            .font(.title3.bold())
                    }
            )
        }
    }
    
    /// Creates a Photo entity object, saves the data into Coredata, saves the photo to disk, and dismisses the sheet
    private func savePhoto() {
        withAnimation {
            let newPhoto = Photo(context: viewContext)
            newPhoto.id = UUID()
            newPhoto.name = self.name
            newPhoto.info = self.info
            newPhoto.filename = newPhoto.id?.uuidString
            newPhoto.timestamp = Date()
            
            newPhoto.photoToLocation = Location(context: viewContext)
            newPhoto.photoToLocation?.latitude = Double(self.latitude) ?? 30.225
            newPhoto.photoToLocation?.longitude = Double(self.longitude) ?? -97.616
            
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
    
    /// Save some new  photo our app directory
    public static func savePhotoToDisk(_ photo: UIImage, as filename: String) {
        do {
            let fullFilename = ContentView.getDocumentsDirectory()
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
        AddPhotoView(image: self.$image, location: CLLocationCoordinate2D(latitude: 30.0, longitude: -97.0))
    }
}
