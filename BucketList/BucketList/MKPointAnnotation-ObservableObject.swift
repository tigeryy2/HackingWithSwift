//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Tiger Yang on 9/29/21.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    // by adding these computed properties, we are able to use this with swiftUI, as we can't bind optional strings to text fields in swiftui
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown title"
        }

        set {
            title = newValue
        }
    }

    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown subtitle"
        }

        set {
            subtitle = newValue
        }
    }
}
