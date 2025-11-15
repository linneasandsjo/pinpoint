//
//  MoreInfoView.swift
//  PinPoint
//
//  Created by Linnea on 2025-10-28.
// hämtar Google Places-info

//BUGGAR gör att programmet crashar
import SwiftUI
import GooglePlaces
import MapKit

struct MoreInfoView: View {
    var place: MKMapItem
    @State private var placeInfo: GMSPlace?
    @State private var errorMessage: String?
    @State private var isLoading = true

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading Google info…")
            } else if let placeInfo = placeInfo {
                Text(placeInfo.name ?? "")
                    .font(.title)
                Text(placeInfo.formattedAddress ?? "")
                    .foregroundColor(.secondary)
                if let rating = placeInfo.rating {
                    Text("⭐️ \(rating)/5")
                }
            } else {
                Text(errorMessage ?? "No info")
            }
        }
        .onAppear {
            fetchGooglePlace()
        }
    }

    // MARK: Step 1: Google Nearby Search from coordinates
    private func fetchGooglePlace() {
        let client = GMSPlacesClient.shared()
        let coord = place.placemark.coordinate

        let request = GMSPlacesNearbySearchRequest(
            locationBias: .circle(
                center: coord,
                radius: 30   // meter
            )
        )

        client.nearbySearch(with: request) { results, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
                return
            }

            guard let googlePlaceID = results?.first?.placeID else {
                self.errorMessage = "No Google place found near this location."
                self.isLoading = false
                return
            }

            fetchGoogleDetails(placeID: googlePlaceID)
        }
    }

    // MARK: Step 2: Fetch place details by ID
    private func fetchGoogleDetails(placeID: String) {
        let client = GMSPlacesClient.shared()
        let fields: GMSPlaceField = [.name, .formattedAddress, .rating, .openingHours]

        client.fetchPlace(fromPlaceID: placeID, placeFields: fields, sessionToken: nil) { place, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else {
                    self.placeInfo = place
                }
            }
        }
    }
}


/*import SwiftUI
import MapKit
import GooglePlaces

struct MoreInfoView: View {
    @State private var placeInfo: GMSPlace?
    var place: MKMapItem

    
    var body: some View {
        PlaceInfoBaseView(place: place) {
            
            VStack {
                if let place = placeInfo {
                    Text(place.name ?? "Unknown")
                        .font(.title)
                    Text(place.formattedAddress ?? "No address")
                } else {
                    Text("Loading...")
                }
            }
            .onAppear {
                let client = GMSPlacesClient.shared()
                client.lookUpPlaceID("ChIJN1t_tDeuEmsRUsoyG83frY4") { place, error in
                    if let place = place {
                        self.placeInfo = place
                    } else if let error = error {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}*/

/*import SwiftUI
import MapKit

struct MoreInfoView: View {
    var place: MKMapItem

    var body: some View {
        PlaceInfoBaseView(place: place) {
            VStack(alignment: .leading, spacing: 8) {
                Text("⭐️ 4.6 (Google rating placeholder)")
                Text("🕓 Open now: 10:00–22:00")
                Text("📍 More details coming soon…")
            }
            .font(.subheadline)
        }
    }
}
*/
