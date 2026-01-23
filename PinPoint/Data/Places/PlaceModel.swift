import Foundation
import MapKit
import FirebaseAuth

struct PlaceModel: Identifiable, Codable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    let createdAt: Date
    let createdBy: String

    /// Init när platsen SKA sparas av en användare
    init(
        id: String,
        name: String,
        latitude: Double,
        longitude: Double,
        createdAt: Date = Date(),
        createdBy: String
    ) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = createdAt
        self.createdBy = createdBy
    }

    /// Init från MapKit (UI-nivå)
    init(mapItem: MKMapItem) {
        self.id = "\(mapItem.placemark.coordinate.latitude)_\(mapItem.placemark.coordinate.longitude)"
        self.name = mapItem.name ?? "Unknown place"
        self.latitude = mapItem.placemark.coordinate.latitude
        self.longitude = mapItem.placemark.coordinate.longitude
        self.createdAt = Date()
        self.createdBy = Auth.auth().currentUser?.uid ?? "unknown"
    }
}
