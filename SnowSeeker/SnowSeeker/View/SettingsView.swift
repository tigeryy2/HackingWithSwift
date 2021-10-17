//
//  SettingsView.swift
//  SnowSeeker
//
//  Created by Tiger Yang on 10/16/21.
//

import SwiftUI

enum SortMethod: String, CaseIterable {
    case alphabetical  = "alphabetical"
    case country
    case none
}

struct FilterMethods {
    let countryFilter: (Resort) -> Bool
    let sizeFilter: (Resort) -> Bool
    let priceFilter: (Resort) -> Bool
    
    /// Default initializer, filters out no resorts
    init() {
        countryFilter = {
            _ in
            true
        }
        
        sizeFilter = {
            _ in
            true
        }
        
        priceFilter = {
            _ in
            true
        }
    }
    
    init(countryFilter: @escaping (Resort) -> Bool, sizeFilter: @escaping (Resort) -> Bool, priceFilter: @escaping (Resort) -> Bool) {
        self.countryFilter = countryFilter
        self.sizeFilter = sizeFilter
        self.priceFilter = priceFilter
    }
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var filterMethods: FilterMethods
    @Binding var selectedCountry: String
    @Binding var selectedPrice: Int
    @Binding var selectedSize: Int
    @Binding var sortMethod: SortMethod
    
    let countries: [String] = ["Any", "Austria", "Canada", "France", "Italy", "United States"]
    let prices: [Int] = [-1, 2, 3]
    let sizes: [Int] = [-1, 1, 2, 3]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sort Method")) {
                    Picker("Sort Method:", selection: $sortMethod) {
                        ForEach(SortMethod.allCases, id: \.self) {
                            Text("\($0.rawValue)")
                                .tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Country Filter")) {
                    Picker("Country Filter", selection: self.$selectedCountry) {
                        ForEach(countries, id:\.self) {
                            Text("\($0)")
                                .tag($0)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.inline)
                }
                .onChange(of: self.selectedCountry) {
                    value in
                    self.filterMethods = FilterMethods(
                        countryFilter: { (resort: Resort) in
                            if value != "Any" {
                                return resort.country == "\(value)"
                            } else {
                                return true
                            }
                        },
                        sizeFilter: filterMethods.sizeFilter,
                        priceFilter: filterMethods.priceFilter)
                }
                
                Section(header: Text("Price Filter")) {
                    Picker("Price Filter", selection: self.$selectedPrice) {
                        ForEach(prices, id:\.self) {
                            if $0 != -1 {
                                Text("\(String(repeating: "$", count: $0))")
                                    .tag($0)
                            } else {
                                Text("Any")
                                    .tag($0)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .onChange(of: self.selectedPrice) {
                    value in
                    self.filterMethods = FilterMethods(
                        countryFilter: filterMethods.countryFilter,
                        sizeFilter: filterMethods.sizeFilter,
                        priceFilter: { (resort: Resort) in
                            if value != -1 {
                                return resort.price == value
                            } else {
                                return true
                            }
                        })
                }
                
                Section(header: Text("Size Filter")) {
                    Picker("Size Filter", selection: self.$selectedSize) {
                        ForEach(sizes, id:\.self) {
                            if $0 != -1 {
                                switch $0 {
                                case 1:
                                    Text("Small")
                                        .tag($0)
                                case 2:
                                    Text("Average")
                                        .tag($0)
                                default:
                                    Text("Large")
                                        .tag($0)
                                }
                            } else {
                                Text("Any")
                                    .tag($0)
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .onChange(of: self.selectedSize) {
                    value in
                    self.filterMethods = FilterMethods(
                        countryFilter: filterMethods.countryFilter,
                        sizeFilter:  { (resort: Resort) in
                            if value != -1 {
                                return resort.size == value
                            } else {
                                return true
                            }
                        },
                        priceFilter: filterMethods.priceFilter)
                }
                
            }
            .navigationTitle(Text("Filtering and Sorting"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    @State static var filterMethods = FilterMethods()
    static let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    static var previews: some View {
        SettingsView(
            filterMethods: self.$filterMethods,
            selectedCountry: .constant("any"),
            selectedPrice: .constant(2),
            selectedSize: .constant(1),
            sortMethod: .constant(.country))
    }
}
