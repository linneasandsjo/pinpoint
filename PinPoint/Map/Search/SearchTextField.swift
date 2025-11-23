//
//  SearchTextField.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-26.
//  Sökrutan

import SwiftUI

struct SearchTextField: View {
    @Binding var query: String
    var isSearching: Bool
    var onFocus: () -> Void
    
    @FocusState private var focused: Bool
    
    var body: some View {
        TextField("Search place…", text: $query)
            .focused($focused)
            .onChange(of: focused) { newValue in
                if newValue {
                    onFocus()
                }
            }
            .padding(12)
            .background(isSearching ? Color(.systemGray5) : Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
    }
}
