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
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if isSearching {
                                isSearching = false
                                hideKeyboard()
                            }
                        }
            
            mainContent
            
            if isSearching {
                searchOverlay
            }
        }
        .onChange(of: query) { newValue in
            handleQueryChange(newValue)
        }
        .animation(.easeInOut, value: isSearching)
    }
}

//när användaren inte söker
private extension SearchBarView {
    var mainContent: some View {
        VStack(spacing: 12) {
            SearchTextField(query: $query, isSearching: isSearching) {
                isSearching = true
            }
            Spacer()
        }
    }
}

//Overlay som visas när användaren söker
private extension SearchBarView {
    var searchOverlay: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                overlayBackground(in: geo)
                
                VStack(spacing: 16) {
                    SearchTextField(query: $query, isSearching: true) {}
                    
                    InspirationSection()
                    
                    PlacesSection(
                        query: query,
                        results: searchVM.results,
                        onSelect: handlePlaceSelection
                    )
                    
                    Spacer()
                }
                .padding(.top, 16)
            }
            .frame(height: UIScreen.main.bounds.height * 0.80)
        }
    }
    
    func overlayBackground(in geo: GeometryProxy) -> some View {
        Color(.systemGray6)
            .opacity(0.98)
            .edgesIgnoringSafeArea(.top)
            .frame(width: geo.size.width,
                   height: geo.size.height * 0.80)
    }
    
}

private extension SearchBarView {
    func handleQueryChange(_ newValue: String) {
        if !newValue.isEmpty {
            searchVM.search(for: newValue)
        } else {
            searchVM.results = []
        }
    }
    
    func handlePlaceSelection(_ item: MKMapItem) {
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

