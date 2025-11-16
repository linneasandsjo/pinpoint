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

    func loadDetails(for mapKitPlace: MKMapItem) async {
        print("📌 [VM] Starting loadDetails for:", mapKitPlace.name ?? "Unknown")   // 🔵 LÄGG TILL
        
        isLoading = true
        defer { isLoading = false }

        do {
            // 1. Få koordinater från MapKit
            let coord = mapKitPlace.placemark.coordinate
            print("📍 [VM] MapKit coord:", coord)   // 🔵 LÄGG TILL


            // 2. Hämta Google PlaceID via REST
            guard let name = mapKitPlace.name else {
                errorMessage = "Missing place name."
                return
            }
            print(" [VM] Google name:", name)

            guard let googleID = try await GooglePlacesREST.shared.getPlaceID(
                for: name,
                near: coord
            ) else {
                print("❌ [VM] Could not get Google PlaceID")   // 🔵 LÄGG TILL
                
                errorMessage = "Could not match MapKit place to Google place."
                return
            }
            print("🔑 [VM] Google PlaceID:", googleID)   // 🔵 LÄGG TILL
            

            // 3. Hämta detaljer via SDK
            let place = try await GooglePlaceDetailsService.shared.fetchDetails(placeID: googleID)
            
            print("🏁 [VM] Final place details:", place)   // 🔵 LÄGG TILL

            self.placeDetails = place

        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

