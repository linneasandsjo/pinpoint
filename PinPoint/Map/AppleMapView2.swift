//
//  AppleMapView.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-21.
//

/*import SwiftUI
import MapKit

struct AppleMapView: UIViewRepresentable {

    @Binding var selectedPlace: MKMapItemWrapper?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let wrapper = selectedPlace {
            uiView.setRegion(
                MKCoordinateRegion(
                    center: wrapper.mapItem.placemark.coordinate,
                    latitudinalMeters: 1000,
                    longitudinalMeters: 1000
                ),
                animated: true
            )
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: AppleMapView
        
        init(_ parent: AppleMapView) { self.parent = parent }

        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let coordinate = view.annotation?.coordinate else { return }

            let placemark = MKPlacemark(coordinate: coordinate)
            let item = MKMapItem(placemark: placemark)
            parent.selectedPlace = MKMapItemWrapper(mapItem: item)
        }
    }
}*/
