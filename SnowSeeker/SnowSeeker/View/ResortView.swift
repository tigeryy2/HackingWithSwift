//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Tiger Yang on 10/15/21.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @EnvironmentObject var favorites: Favorites
    @State private var selectedFacility: Facility?
    
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    Image(decorative: resort.id)
                        .resizable()
                    .scaledToFit()
                    
                    // text in bottom right
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Credit: \(resort.imageCredit)")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .background(Color.white.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 1))
                        }
                    }
                }
                
                Group {
                    HStack {
                        // iOS tells us if horizontal size is "regular" or "compact"
                        if sizeClass == .compact {
                            Spacer()
                            VStack { ResortDetailsView(resort: resort) }
                            VStack { SkiDetailsView(resort: resort) }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            
            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                if self.favorites.contains(self.resort) {
                    self.favorites.remove(self.resort)
                } else {
                    self.favorites.add(self.resort)
                }
            }
            .padding()
        }
        .alert(item: $selectedFacility) {
            facility in
            facility.alert
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    @ObservedObject static var favorites = Favorites()
    
    static var previews: some View {
        ResortView(resort: Resort.example).environmentObject(favorites)
    }
}
