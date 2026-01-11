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
        
        mapView.pointOfInterestFilter = .includingAll

        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // När selectedPlace ändras, flytta kartan och sätt pin
        if let wrapper = selectedPlace {
            let coordinate = wrapper.mapItem.placemark.coordinate
            
            // Flytta kartan
            let region = MKCoordinateRegion(
                center: coordinate,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )
            uiView.setRegion(region, animated: true)
            
            // Rensa gamla annotationer
            uiView.removeAnnotations(uiView.annotations)
            
            // Lägg till ny annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = wrapper.mapItem.name
            uiView.addAnnotation(annotation)
            
            // Sluta följa användaren så kartan stannar kvar på platsen
            uiView.userTrackingMode = .none
        }
    }
    
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: AppleMapView
        
        init(_ parent: AppleMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let annotation = view.annotation else { return }

            // 1. Ignorera användarens blå punkt
            if annotation is MKUserLocation {
                return
            }

            // 2. Försök hämta riktig platsinfo genom lokal sökning
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = annotation.title ?? ""
            request.region = MKCoordinateRegion(
                center: annotation.coordinate,
                latitudinalMeters: 500,
                longitudinalMeters: 500
            )

            MKLocalSearch(request: request).start { response, error in
                if let item = response?.mapItems.first {
                    // Vi fick en riktig plats → använd den
                    self.parent.selectedPlace = MKMapItemWrapper(mapItem: item)
                    return
                }

                // 3. Fallback om ingen riktig plats hittades
                let placemark = MKPlacemark(coordinate: annotation.coordinate)
                let fallbackItem = MKMapItem(placemark: placemark)
                fallbackItem.name = annotation.title ?? "Unknown Place"

                self.parent.selectedPlace = MKMapItemWrapper(mapItem: fallbackItem)
            }
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

import SwiftUI
import MapKit

/*struct AppleMapView: View {
    @Binding var selectedPlace: MKMapItemWrapper?

    @State private var camera: MapCameraPosition = .automatic
    @State private var searchResults: [MKMapItem] = []
    @State private var selectedFeature: MapFeature? = nil

    var body: some View {
        Map(position: $camera,
            interactionModes: .all,
            selection: $selectedFeature
        ) {

            // Visa dina sökresultat som klickbara
            ForEach(searchResults, id: \.self) { item in
                Annotation(item.name ?? "Plats",
                           coordinate: item.placemark.coordinate) {
                    ZStack {
                        Circle()
                            .fill(.blue)
                            .frame(width: 12, height: 12)
                    }
                }
                .mapItem(item) // <-- Kopplar annotationen till MKMapItem
            }
        }

        // Endast POIs från Apple ska vara klickbara
        .mapFeatureSelectionDisabled { feature in
            feature.kind != .pointOfInterest
        }

        // Visar Apples egna infoblad automatiskt
        .mapFeatureSelectionAccessory(.automatic)

        // När användaren trycker på en Apple POI
        .sheet(item: $selectedFeature) { feature in
            if let item = feature.mapItem {
                MapItemDetail(item)
            }
        }

        // När användaren trycker på en av dina egna sökresultat
        .sheet(item: $selectedPlace) { wrapper in
            PlaceInfoView(place: wrapper.mapItem)
        }

        .onAppear { loadInitialPOIs() }
    }

    func loadInitialPOIs() {
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 55.7047, longitude: 13.1910),
            latitudinalMeters: 5000,
            longitudinalMeters: 5000
        )

        let req = MKLocalSearch.Request()
        req.region = region
        req.pointOfInterestFilter = .includingAll

        MKLocalSearch(request: req).start { resp, _ in
            if let items = resp?.mapItems {
                searchResults = items
            }
        }
    }
}*/


