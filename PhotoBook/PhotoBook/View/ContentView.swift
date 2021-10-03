//
//  ContentView.swift
//  PhotoBook
//
//  Created by Tiger Yang on 10/1/21.
//

import SwiftUI
import CoreData
import CoreLocation

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Photo.name, ascending: true)],
        animation: .default)
    private var photos: FetchedResults<Photo>
    
    @State private var chosenImage: UIImage?
    @State private var showingAddPhoto = false
    @State private var showingImagePicker = false
    
    let locationFetcher = LocationFetcher()
    
    init() {
        // on startup, make sure we have the placeholder image saved to disk
        let fullFilename = ContentView.getDocumentsDirectory()
            .appendingPathComponent("placeholder")
        
        // if placeholder image is not already saved to disk, save it
        if !(FileManager.default.fileExists(atPath: fullFilename.path)) {
            let image = UIImage(named: "placeholder")!
            AddPhotoView.savePhotoToDisk(image, as: "placeholder")
        }
        
        // start location searching, so we have the location ready later
        locationFetcher.start()
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
                .onDelete(perform: deletePhotos)
            }
            // sheet for adding a photo and editing info
            .sheet(isPresented: self.$showingAddPhoto) {
                AddPhotoView(image: self.$chosenImage, location: self.locationFetcher.lastKnownLocation ?? CLLocationCoordinate2D(latitude: 30.0, longitude: -97.0))
            }
            // sheet for image picker
            // dismissal triggers the add photo sheet
            .sheet(isPresented: self.$showingImagePicker,
                   onDismiss: self.addPhoto) {
                ImagePicker(image: self.$chosenImage)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink("View Map") {
                        PhotoMapView()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    // + button triggers choose photo sheet
                    Button(action: self.choosePhoto) {
                        Label("Add Photo", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    /// Trigger add photo sheet
    private func addPhoto() {
        self.showingAddPhoto = true
    }
    
    /// Trigger image picker sheet
    private func choosePhoto() {
        // trigger imagepicker sheet to show
        self.showingImagePicker = true
    }
    
    private func deletePhotos(offsets: IndexSet) {
        withAnimation {
            offsets.map { $0 }.forEach(self.deletePhotoFromCoreData)
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
    
    /// Delete the photo on disk associated with the photos offset from disk
    private func deletePhotoFromCoreData(offset: Int) {
        let filename = self.photos[offset].wrappedFilename
        
        // do not delete placenholder image
        if filename == "placeholder" {
            return
        }
        
        let fullFilename = ContentView.getDocumentsDirectory()
            .appendingPathComponent(filename)
        
        // check that file exists, and that it's deletable
        if (FileManager.default.fileExists(atPath: fullFilename.path)) {
            if (FileManager.default.isDeletableFile(atPath: fullFilename.path)) {
                try! FileManager.default.removeItem(atPath: fullFilename.path)
            }
        }
    }
    
    /// Standard function to return the current app's documents directory
    public static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
