//
//  GooglePlacesService.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-15.
//

import Foundation
import GooglePlaces
import CoreLocation

class GooglePlacesService {

    private let client = GMSPlacesClient.shared()

    // 1️⃣ Hitta Google Place ID från koordinater
    func fetchPlaceID(from coordinate: CLLocationCoordinate2D) async throws -> String? {

        let fields: GMSPlaceField = [.name, .placeID]

        return try await withCheckedThrowingContinuation { continuation in
            client.findPlaceLikelihoodsFromLocation(
                coordinate,
                radius: 50,
                placeFields: fields
            ) { likelihoods, error in

                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                let placeID = likelihoods?.first?.place.placeID
                continuation.resume(returning: placeID)
            }
        }
    }

    // 2️⃣ Hämta detaljer baserat på Google Place ID
    func fetchPlaceDetails(placeID: String) async throws -> GMSPlace {

        let fields: GMSPlaceField = [
            .name,
            .rating,
            .formattedAddress,
            .openingHours,
            .userRatingsTotal,
            .photos
        ]

        return try await withCheckedThrowingContinuation { continuation in
            client.fetchPlace(
                fromPlaceID: placeID,
                placeFields: fields
            ) { place, error in

                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                if let place = place {
                    continuation.resume(returning: place)
                }
            }
        }
    }
}
