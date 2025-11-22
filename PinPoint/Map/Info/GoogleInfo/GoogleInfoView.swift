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
                    
                    ReviewsInfoView(rating: details.rating)
                    
                    if let hours = details.openingHours {
                        OpeningHoursView(hours: hours)
                    }
                    
                    if let phoneNumber = details.phoneNumber {
                        HStack {
                            Image(systemName: "phone")
                            Text("\(phoneNumber)")
                        }
                    }
                    
                    if let website = details.website {
                        HStack {
                            Image(systemName: "globe")
                            Link("Visit website", destination: website)
                        }
                    }
                    
                    if !vm.photos.isEmpty{
                        PhotosView(photos: vm.photos)
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
