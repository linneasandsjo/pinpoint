//
//  SavePlaceButton.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-11.
//

import SwiftUI
import MapKit

struct SavePlaceButton: View {

    let place: MKMapItem
    private let placeService = PlaceService.shared

    @State private var isSaved = false
    @State private var isLoading = false

    var body: some View {
        Button {
            toggleSave()
        } label: {
            Label(
                isSaved ? "Added to your list" : "Add to your list",
                systemImage: isSaved ? "heart.fill" : "heart"
            )
            .foregroundColor(.pink)
        }
        .disabled(isLoading)
        .task {
            await loadSaveState()
        }
    }

    private func loadSaveState() async {
        let placeId = placeId()
        isSaved = (try? await placeService.isPlaceSaved(placeId: placeId)) ?? false
    }

    private func toggleSave() {
        isLoading = true

        Task {
            let placeId = placeId()

            if isSaved {
                try? await placeService.removePlace(placeId: placeId)
            } else {
                try? await placeService.savePlace(place)
            }

            isSaved.toggle()
            isLoading = false
        }
    }

    private func placeId() -> String {
        "\(place.placemark.coordinate.latitude)_\(place.placemark.coordinate.longitude)"
    }
}
