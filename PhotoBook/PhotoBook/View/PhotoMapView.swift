//
//  PhotoMapView.swift
//  PhotoBook
//
//  Created by Tiger Yang on 10/2/21.
//

import MapKit
import SwiftUI

struct PhotoMapView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Photo.name, ascending: true)],
        animation: .default)
    private var photos: FetchedResults<Photo>
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var photoAnnotations = [PhotoMKPointAnnotation]()
    @State private var selectedPlace: PhotoMKPointAnnotation?
    @State private var showingPlaceDetails = false
    
    var body: some View {
        ZStack {
            MapView(
                centerCoordinate: self.$centerCoordinate,
                selectedPlace: self.$selectedPlace,
                showingPlaceDetails: self.$showingPlaceDetails,
                annotations: self.photoAnnotations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.25)
                .frame(width: 32, height: 32)
        }
        .sheet(isPresented: self.$showingPlaceDetails) {
            PhotoDetailView(photo: self.selectedPlace!.photo)
        }
        // creates an annotation for each photo
        .onAppear(perform: loadAnnotations)
    }
    
    /// For each photo that we have, creates an annotation for it
    private func loadAnnotations() {
        for photo in photos {
            let newPhotoAnnotation = PhotoMKPointAnnotation(photo: photo)
            self.photoAnnotations.append(newPhotoAnnotation)
            
            self.selectedPlace = newPhotoAnnotation
        }
    }
}

struct PhotoMapView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoMapView()
    }
}
