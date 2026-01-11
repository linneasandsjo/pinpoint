//
//  PlaceModel.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-11.
//
import Foundation
import MapKit

struct PlaceModel: Identifiable, Codable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    let createdAt: Date

    init(mapItem: MKMapItem) {
        self.id = "\(mapItem.placemark.coordinate.latitude)_\(mapItem.placemark.coordinate.longitude)"
        self.name = mapItem.name ?? "Unknown place"
        self.latitude = mapItem.placemark.coordinate.latitude
        self.longitude = mapItem.placemark.coordinate.longitude
        self.createdAt = Date()
    }
}
