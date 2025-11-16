//
//  MoreInfoView.swift
//  PinPoint
//
//  Created by Linnea on 2025-10-28.
// hämtar Google Places-info

import SwiftUI
import MapKit
import GooglePlaces

struct MoreInfoView: View {
    var place: MKMapItem
    @StateObject private var vm = MoreInfoViewModel()

    var body: some View {
        PlaceInfoBaseView(place: place) {

            if vm.isLoading {
                ProgressView("Loading Google details…")
            }
            else if let details = vm.placeDetails {

                VStack(alignment: .leading, spacing: 8) {
                    Text(details.name ?? "No name")
                        .font(.title3)

                    let rating = details.rating
                    if rating > 0 {
                        Text("⭐️ Rating: \(rating, specifier: "%.1f")")
                    }
                    else {
                        Text("⭐️ No rating available")
                    }

                    if let hours = details.openingHours?.weekdayText {
                        ForEach(hours, id: \.self) { day in
                            Text(day)
                        }
                    }

                    if let website = details.website {
                        Link("Visit website", destination: website)
                    }
                }

            } else if let error = vm.errorMessage {
                Text("Error: \(error)")
            }
        }
        .task {
            await vm.loadDetails(for: place)
        }
    }
}
