//
//  GooglePlaceDetailsService.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-15.
//

import GooglePlaces

class GooglePlaceDetailsService {
    static let shared = GooglePlaceDetailsService()
    private init() {}

    func fetchDetails(placeID: String) async throws -> GMSPlace {
        
        return try await withCheckedThrowingContinuation { continuation in

            let fields: GMSPlaceField = [
                .name,
                .formattedAddress,
                .openingHours,
                .rating,
                .photos,
                .phoneNumber,
                .website
            ]

            let token = GMSAutocompleteSessionToken.init()

            DispatchQueue.main.async {
                GMSPlacesClient.shared().fetchPlace(
                    fromPlaceID: placeID,
                    placeFields: fields,
                    sessionToken: token,
                    callback: { place, error in
                        if let error = error {
                            continuation.resume(throwing: error)
                            return
                        }
                        if let place = place {
                            continuation.resume(returning: place)
                        } else {
                            continuation.resume(
                                throwing: NSError(domain: "GooglePlaces", code: -1)
                            )
                        }
                    }
                    
                )
            }
        }
    }
}
