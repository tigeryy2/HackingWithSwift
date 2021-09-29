//
//  UnlockedContentView.swift
//  BucketList
//
//  Created by Tiger Yang on 9/29/21.
//

import MapKit
import SwiftUI

struct UnlockedContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var places = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingEditPlaceView = false
    @State private var showingPlaceDetails = false
    
    var body: some View {
        ZStack {
            MapView(
                centerCoordinate: self.$centerCoordinate,
                selectedPlace: self.$selectedPlace,
                showingPlaceDetails: self.$showingPlaceDetails,
                annotations: self.places)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.25)
                .frame(width: 32, height: 32)
            // Place button in buttom right corner
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // add current coord to list of places
                        let newPlace = CodableMKPointAnnotation()
                        newPlace.coordinate = self.centerCoordinate
                        newPlace.title = "Example Location"
                        self.places.append(newPlace)
                        
                        // allow user to edit details for new place
                        self.selectedPlace = newPlace
                        self.showingEditPlaceView = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .font(.title)
                    .background(Color.black.opacity(0.59))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .overlay(Circle().stroke().foregroundColor(Color.white.opacity(0.75)))
                    .padding(.trailing)
                }
            }
            
        }
        .alert(isPresented: self.$showingPlaceDetails) {
            Alert(
                title: Text(self.selectedPlace?.title ?? "Unknown"),
                message: Text(self.selectedPlace?.subtitle ?? "Missing place information."),
                primaryButton: .default(Text("OK")),
                secondaryButton: .default(Text("Edit")) {
                    // allow user to edit place info
                    self.showingEditPlaceView = true
                })
        }
        .sheet(isPresented: self.$showingEditPlaceView, onDismiss: saveData) {
            if self.selectedPlace != nil {
                // we can force unwrap here, since we just checked to make sure it's not nil..
                EditView(placemark: self.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    /// Standard function to return the current app's documents directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    /// Load our places from app directory
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: filename)
            self.places = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    /// Save our places to app directory
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.places)
            
            // use options to write at once, and provide encryption
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

struct UnlockedContentView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockedContentView()
    }
}
