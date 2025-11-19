//
//  MoreInfoViewModel.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-15.
//

import Foundation
import MapKit
import GooglePlaces

@MainActor
class MoreInfoViewModel: ObservableObject {
    @Published var placeDetails: GMSPlace?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var photos: [UIImage] = []

    func loadDetails(for mapKitPlace: MKMapItem) async {
        isLoading = true
        defer { isLoading = false }

        do {
            // 1. Få koordinater från MapKit
            let coord = mapKitPlace.placemark.coordinate

            // 2. Hämta Google PlaceID via REST
            guard let name = mapKitPlace.name else {
                errorMessage = "Missing place name."
                return
            }
            
            guard let googleID = try await GooglePlacesREST.shared.getPlaceID(
                for: name,
                near: coord
            ) else {
                errorMessage = "Could not match MapKit place to Google place."
                return
            }
          
            // 3. Hämta detaljer via SDK
            let place = try await GooglePlaceDetailsService.shared.fetchDetails(placeID: googleID)
           
            self.placeDetails = place
            loadPhotos(from: place)

        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func loadPhotos(from details: GMSPlace) {
        guard let metadataList = details.photos else { return }

        let maxPhotos = Array(metadataList.prefix(1))  //MAX 1 foto laddas!

        for meta in maxPhotos {
            GMSPlacesClient.shared().loadPlacePhoto(meta) { image, error in
                if let image = image {
                    Task { @MainActor in
                        self.photos.append(image)
                    }
                }
            }
        }
    }
}
