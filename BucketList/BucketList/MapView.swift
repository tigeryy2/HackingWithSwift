//
//  MapView.swift
//  BucketList
//
//  Created by Tiger Yang on 9/27/21.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    var annotations: [MKPointAnnotation]
    
    // notified and takes control when something "interesting" happens
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        // funcs with particular signatures are looked for here, to decide which events notify and trigger actions
        
        // fetch view for annotation, automatically called by swift when needed
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // this is our unique identifier for view reuse
            let identifier = "Placemark"
            
            // attempt to find a cell we can recycle
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                // we didn't find one; make a new one
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                
                // allow this to show pop up information
                annotationView?.canShowCallout = true
                
                // attach an information button to the view
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                // we found a view to reuse, so give it the new annotation
                annotationView?.annotation = annotation
            }
            
            // whether it's a new view or a recycled one, send it back
            return annotationView
        }
        
        // gets called when the "i" button on the annotation view gets pressed
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            // check that we have valid annotation
            guard let placemark = view.annotation as? MKPointAnnotation else { return }
            
            // pass the clicked place to the parent, and trigger alert
            parent.selectedPlace = placemark
            parent.showingPlaceDetails = true
        }
        
        // automatically called whenever visible region is changed..
        // e.g. zoomed, dragged to new area...
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            // pass new center coord to the parent's binding
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
    }
    
    // called automatically by swift
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // use type alias "Context" instead of "UIViewRepresentableContext<MapView>"
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        // compares changed list of annotations to current list of annotations, if number is different, then we've added or removed an annotation
        if annotations.count != view.annotations.count {
            view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    
    static var previews: some View {
        MapView(
            centerCoordinate: .constant(MKPointAnnotation.example.coordinate),
            selectedPlace: .constant(MKPointAnnotation.example),
            showingPlaceDetails: .constant(false),
            annotations: [MKPointAnnotation.example])
    }
}

// add some sample data for the preview
extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}
