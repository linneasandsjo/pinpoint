//
//  SearchOverlayView.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-23.
//

import SwiftUI
import MapKit

struct SearchOverlayView: View {
    @Binding var query: String
    var results: [MKMapItem]
    var searchFieldFocused: FocusState<Bool>.Binding
    let onSelect: (MKMapItem) -> Void

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {

                SearchBackground(height: geo.size.height)

                VStack(spacing: 16) {
                    SearchTextField(
                        query: $query,
                        isSearching: true,
                        onFocus: {}
                    )
                    .focused(searchFieldFocused)

                    InspirationSection()

                    PlacesSection(
                        query: query,
                        results: results,
                        onSelect: onSelect
                    )

                    Spacer()
                }
                .frame(height: UIScreen.main.bounds.height * 0.80)
                .padding(.top, 16)
            }
        }
        .frame(height: UIScreen.main.bounds.height * 0.89)
    }
}

