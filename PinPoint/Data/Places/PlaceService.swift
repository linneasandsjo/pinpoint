//
//  PlaceService.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-11.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth
import MapKit

final class PlaceService {

    static let shared = PlaceService()
    private let db = Firestore.firestore()

    private init() {}

    // MARK: - Save place
    func savePlace(_ mapItem: MKMapItem) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "NoUser", code: 401)
        }

        let place = PlaceModel(mapItem: mapItem)

        try await db
            .collection("users")
            .document(userId)
            .collection("savedPlaces")
            .document(place.id)
            .setData([
                "name": place.name,
                "latitude": place.latitude,
                "longitude": place.longitude,
                "createdAt": Timestamp(date: place.createdAt)
            ])
    }

    // MARK: - Remove place
    func removePlace(placeId: String) async throws {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        try await db
            .collection("users")
            .document(userId)
            .collection("savedPlaces")
            .document(placeId)
            .delete()
    }

    // MARK: - Check if saved
    func isPlaceSaved(placeId: String) async throws -> Bool {
        guard let userId = Auth.auth().currentUser?.uid else { return false }

        let doc = try await db
            .collection("users")
            .document(userId)
            .collection("savedPlaces")
            .document(placeId)
            .getDocument()

        return doc.exists
    }
}
