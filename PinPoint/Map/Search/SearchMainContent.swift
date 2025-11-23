//
//  SearchMainContent.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-23.
//

import SwiftUI

struct SearchMainContent: View {
    @Binding var query: String
    var isSearching: Bool
    var searchFieldFocused: FocusState<Bool>.Binding
    let onStartSearching: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            SearchTextField(query: $query, isSearching: isSearching) {
                onStartSearching()
            }
            .focused(searchFieldFocused)

            Spacer()
        }
    }
}
