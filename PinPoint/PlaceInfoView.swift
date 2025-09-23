//
//  PlaceInfoView.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-23.
//

import SwiftUI
import MapKit

struct PlaceInfoView: View {
    var place: MKMapItem

    var body: some View {
        VStack(spacing: 12) {
            Text(place.name ?? "Unknown place")
                .font(.headline)

            if let address = place.placemark.title {
                Text(address)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            if let phone = place.phoneNumber {
                Text("📞 \(phone)")
            }

            if let url = place.url {
                Link("🌐 Visit website", destination: url)
            }
        }
        .padding()
    }
}
