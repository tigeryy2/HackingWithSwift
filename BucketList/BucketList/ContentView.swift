//
//  ContentView.swift
//  BucketList
//
//  Created by Tiger Yang on 9/26/21.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var places = [MKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
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
                        let newPlace = MKPointAnnotation()
                        newPlace.coordinate = self.centerCoordinate
                        newPlace.title = "Example Location"
                        self.places.append(newPlace)
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
                // edit this place
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
