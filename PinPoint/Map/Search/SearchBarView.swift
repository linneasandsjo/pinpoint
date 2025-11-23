//
//  SearchBarView.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-23.
//

import SwiftUI
import MapKit

struct SearchBarView: View {
    @ObservedObject var searchVM: SearchViewModel
    @Binding var selectedPlace: MKMapItemWrapper?

    @State private var query = ""
    @State private var isSearching = false
    @FocusState private var searchFieldFocused: Bool

    var body: some View {
        ZStack(alignment: .top) {

            // Main content when not searching
            SearchMainContent(
                query: $query,
                isSearching: isSearching,
                searchFieldFocused: $searchFieldFocused,
                onStartSearching: startSearching
            )
            .allowsHitTesting(!isSearching)

            // Tap outside to close
            if isSearching {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        searchFieldFocused = false
                        hideKeyboard()
                        withAnimation(.easeInOut) { isSearching = false }
                    }
            }

            // Overlay when searching
            if isSearching {
                SearchOverlayView(
                    query: $query,
                    results: searchVM.results,
                    searchFieldFocused: $searchFieldFocused,
                    onSelect: handlePlaceSelection
                )
                .transition(.move(edge: .top))
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }
        .animation(.easeInOut, value: isSearching)
        .onChange(of: query, perform: handleQueryChange)
    }
}

// MARK: - Handlers
extension SearchBarView {
    private func startSearching() {
        isSearching = true
        searchFieldFocused = true
    }

    private func handleQueryChange(_ newValue: String) {
        if !newValue.isEmpty {
            searchVM.search(for: newValue)
        } else {
            searchVM.results = []
        }
    }

    private func handlePlaceSelection(_ item: MKMapItem) {
        selectedPlace = MKMapItemWrapper(mapItem: item)
        isSearching = false
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
#endif


