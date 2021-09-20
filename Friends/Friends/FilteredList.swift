//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Tiger Yang on 9/15/21.
//

import SwiftUI
import CoreData

enum Predicate: String {
    case beginsWith = "BEGINSWITH"
    case beginsWithNoCase = "BEGINSWITH[c]"
    case isIn = "IN"
    case contains = "CONTAINS"
    case like = "like"
    case matches = "MATCHES"
    
    // not a swift predicate, use to show all
    case noPredicate = "none"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    let content: (T) -> Content
    
    init(
        filterKey: String,
        filterValue: String,
        predicate: Predicate,
        sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        
        // init fetchRequest
        self.fetchRequest = FetchRequest<T>(
            entity: T.entity(),
            sortDescriptors: sortDescriptors,
            // if "none" given, use a predicate that allows all
            predicate: (predicate.rawValue == "none") ? NSPredicate(format: "%K LIKE[c] '*'", filterKey) : NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue),
            animation: .easeInOut)
        
        self.content = content
    }
    
    // w/o the @FetchRequest, need to grab the values out of the ".wrappedValue"
    // note, don't be an idiot and try to set the intial fetchRequest to FetchResults instead... this NEEDs to be computed value, so that it keeps updating!!
    var unwrappedValues: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    
    var body: some View {
        List(self.unwrappedValues, id: \.self) { item in
            self.content(item)
        }
        .animation(.easeInOut)
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(
            filterKey: "name",
            filterValue: "T",
            predicate: .matches,
            sortDescriptors: [NSSortDescriptor(keyPath: \UserEntity.name, ascending: true)]) {
            (user: UserEntity) in
            Text("\(user.name!)")
        }
    }
}
