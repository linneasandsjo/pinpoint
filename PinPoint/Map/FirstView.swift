//
//  FirstView.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-21.
//
import SwiftUI
import MapKit

struct FirstView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var searchVM = SearchViewModel()

    @State private var selectedPlace: MKMapItemWrapper?
    @State private var showPlaceInfo = false

    var body: some View {
        ZStack {
            AppleMapView(selectedPlace: $selectedPlace)
                .edgesIgnoringSafeArea(.top)

            SearchBarView(searchVM: searchVM, selectedPlace: $selectedPlace)
        }
        .sheet(item: $selectedPlace) { wrapper in
                    NavigationStack {
                        PlaceInfoView(place: wrapper.mapItem)
                    }
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                }
    }
}
