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
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    let content: (T) -> Content
    
    init(
        filterKey: String,
        filterValue: String,
        predicate: Predicate,
        sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(
            entity: T.entity(),
            sortDescriptors: sortDescriptors,
            predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
    
    // w/o the @FetchRequest, need to grab the values out of the ".wrappedValue"
    var unwrappedValues: FetchedResults<T> {
        fetchRequest.wrappedValue
    }
    
    var body: some View {
        List(self.unwrappedValues, id: \.self) { item in
            self.content(item)
        }
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(
            filterKey: "name",
            filterValue: "T",
            predicate: .beginsWithNoCase,
            sortDescriptors: [NSSortDescriptor(keyPath: \UserEntity.name, ascending: true)]) {
            (user: UserEntity) in
            Text("\(user.name!)")
        }
    }
}
