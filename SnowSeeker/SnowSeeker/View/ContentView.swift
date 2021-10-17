//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Tiger Yang on 10/13/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @ObservedObject var favorites = Favorites()
    @State private var filterMethods: FilterMethods = FilterMethods()
    @State private var selectedCountry = "any"
    @State private var selectedPrice = -1
    @State private var selectedSize = -1
    @State private var sortMethod: SortMethod = .country
    @State private var showingSettings: Bool = false
    
    var filteredResorts: [Resort] {
        resorts
            .sorted(by: getSortMethod(sortMethod: self.sortMethod))
            .filter(filterMethods.countryFilter)
            .filter(filterMethods.priceFilter)
            .filter(filterMethods.sizeFilter)
    }
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showingSettings = true
                    }) {
                        Text("Filter")
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView(
                    filterMethods: self.$filterMethods,
                    selectedCountry: $selectedCountry,
                    selectedPrice: $selectedPrice,
                    selectedSize: $selectedSize,
                    sortMethod: $sortMethod)
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        .phoneOnlyStackNavigationView()
    }
    
    func getSortMethod(sortMethod: SortMethod) -> (Resort, Resort) -> Bool {
        switch sortMethod {
        case .alphabetical:
            return { $0.name < $1.name }
        case .country:
            return { $0.country < $1.country }
        case .none:
            return { (_:Resort, _:Resort) in
                true
            }
        }
    }
}

extension View {
    // example of type erasure, as return views in the if/else are diff
    func phoneOnlyStackNavigationView() -> some View {
        // force StackNavigationViewStyle on all phones
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
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
