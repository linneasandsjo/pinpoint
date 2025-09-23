//
//  MapView.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-23.
// Using Apples MapKit

import SwiftUI
import MapKit
import CoreLocation
import UIKit


struct AppleMapView: UIViewRepresentable {
    @Binding var selectedPlace: MKMapItemWrapper? // för att kunna visa info när man klickar
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow // följer användarens position
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: AppleMapView
        
        init(_ parent: AppleMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let annotation = view.annotation else { return }
            
            // Hämta MKMapItem från annotationens koordinat
            let placemark = MKPlacemark(coordinate: annotation.coordinate)
            let item = MKMapItem(placemark: placemark)

            parent.selectedPlace = MKMapItemWrapper(mapItem: item)
        }
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization() // fråga om tillstånd
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Current location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    }
}
