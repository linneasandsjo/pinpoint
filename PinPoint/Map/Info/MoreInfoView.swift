//
//  MoreInfoView.swift
//  PinPoint
//
//  Created by Linnea on 2025-10-28.
// hämtar Google Places-info

import SwiftUI
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
