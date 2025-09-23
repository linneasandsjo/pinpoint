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

    var body: some View {
        VStack {
            TextField("Search place…", text: $query, onCommit: {
                searchVM.search(for: query)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()

            if !searchVM.results.isEmpty {
                List(searchVM.results, id: \.self) { item in
                    Button(action: {
                        selectedPlace = MKMapItemWrapper(mapItem: item)
                    }) {
                        Text(item.name ?? "Unknown")
                    }
                }
                .frame(maxHeight: 200)
            }

            Spacer()
        }
    }
}
