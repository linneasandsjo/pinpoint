//
//  ContentView.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-14.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        TabView {
            FirstView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            
            SecondView()
                .tabItem {
                    Label("Save", systemImage: "heart")
                }
            
            ThirdView()
                .tabItem {
                    Label("Friends", systemImage: "person.2")
                }
        }
    }
}

struct FirstView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var searchVM = SearchViewModel()
    @State private var selectedPlace: MKMapItemWrapper?
    
    var body: some View {
            ZStack {
                // Kallar på MapView och skickar in state
                AppleMapView(selectedPlace: $selectedPlace)

                // Lägger över din sökvy ovanpå kartan
                SearchBarView(searchVM: searchVM, selectedPlace: $selectedPlace)
            }
            // Info-popup i separat vy
            .sheet(item: $selectedPlace) { wrapper in
                PlaceInfoView(place: wrapper.mapItem)
            }
        }
}


struct SecondView: View {
    var body: some View {
        Text("List over saved items")
            .font(.largeTitle)
            .padding()
    }
}

struct ThirdView: View {
    var body: some View {
        Text("Friends view, activities from friends")
            .font(.largeTitle)
            .padding()
    }
}

#Preview {
    ContentView()
}


struct MKMapItemWrapper: Identifiable {
    let id = UUID()
    let mapItem: MKMapItem
}

