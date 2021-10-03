//
//  LocationFetcher.swift
//  PhotoBook
//
//  Created by Tiger Yang on 10/2/21.
//

import CoreLocation
import Foundation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    /// Returns current location
    func getLocation() -> CLLocationCoordinate2D {
        self.start()
        
        guard let location = self.lastKnownLocation else {
            // return giga texas lat/long by default...
            return CLLocationCoordinate2D(latitude: 30.222533604458075, longitude: -97.61673317398859)
        }
        
        return location
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
