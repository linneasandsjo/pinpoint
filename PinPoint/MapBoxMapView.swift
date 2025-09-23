//
//  MapBoxMapView.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-21.

import SwiftUI
import MapboxMaps
import UIKit
import CoreLocation

struct MapBoxMapView: UIViewControllerRepresentable {
     
    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }
      
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {}
}


class MapViewController: UIViewController, CLLocationManagerDelegate {
    internal var mapView: MapView!
    let locationProvider = AppleLocationProvider()
    let locationManager = CLLocationManager()
    private var hasCenteredOnUser = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initiera MapView med default MapInitOptions (token hämtas från PinPoint(app-ikonen)>Targets>Info>Key:MGLMapboxAccessToken)
        let mapInitOptions = MapInitOptions()
        mapView = MapView(frame: view.bounds, mapInitOptions: mapInitOptions)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)

        mapView.location.override(provider: locationProvider)

        mapView.location.options.puckType = .puck2D()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
   func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
       switch manager.authorizationStatus {
       case .authorizedWhenInUse, .authorizedAlways:
           locationManager.startUpdatingLocation()
       case .denied, .restricted:
           print("Platsåtkomst nekad")
       case .notDetermined:
           break
       @unknown default:
           break
       }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !hasCenteredOnUser, let userLocation = locations.last else { return }
        
        let cameraOptions = CameraOptions(center: userLocation.coordinate, zoom: 14.0)
        mapView.mapboxMap.setCamera(to: cameraOptions)
        
        hasCenteredOnUser = true
    }
}
