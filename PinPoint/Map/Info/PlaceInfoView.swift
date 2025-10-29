//
//  PlaceInfoView.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-23.
// skickar bara platsen (MapKit)

import SwiftUI
import MapKit

struct PlaceInfoView: View {
    var place: MKMapItem
    @State private var showMoreInfo = false

    var body: some View {
        PlaceInfoBaseView(place: place) {
            // Adress
            if let address = place.placemark.title {
                Text(address)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            // Webblänk
            if let url = place.url {
                Link("🌐 Visit website", destination: url)
                    .font(.subheadline)
            }

            // “More info”-knapp (öppnar Google-detaljer)
            Button("More info") {
                showMoreInfo = true
            }
            .font(.headline)
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
            .background(Color.blue.opacity(0.85))
            .foregroundColor(.white)
            .cornerRadius(10)
            .sheet(isPresented: $showMoreInfo) {
                MoreInfoView(place: place)
            }
        }
    }
}
