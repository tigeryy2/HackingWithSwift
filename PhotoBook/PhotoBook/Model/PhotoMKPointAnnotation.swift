//
//  PhotoMKPointAnnotation.swift
//  PhotoBook
//
//  Created by Tiger Yang on 10/2/21.
//

import Foundation
import MapKit

/// Subclass of MKPointAnnotation that has a Photo attribute
class PhotoMKPointAnnotation: MKPointAnnotation {
    var photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        super.init()
        
        self.title = photo.wrappedName
        self.subtitle = photo.wrappedInfo
        
        let photoLocation = photo.photoToLocation
        self.coordinate = CLLocationCoordinate2D(latitude: photoLocation?.latitude ?? 30.2225, longitude: photoLocation?.longitude ?? -97.6167)
    }
}
