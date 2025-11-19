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
                    
                    let rating = details.rating
                    if rating > 0 {
                        HStack {
                            Text("\(rating, specifier: "%.1f")")
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                            Text("(Source: Google)").foregroundColor(.gray)

                        }
                    }
                    else {
                        HStack {
                            Image(systemName: "star.fill")
                            Text("No rating available")
                        }
                    }
                    
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
                    
                    if !vm.photos.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(vm.photos.indices, id: \.self) { index in
                                    Image(uiImage: vm.photos[index])
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 250, height: 180)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .shadow(radius: 4)
                                }
                            }
                        }
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
