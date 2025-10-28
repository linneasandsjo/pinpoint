//
//  SearchViewModel.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-23.
//
import Foundation
import MapKit

class SearchViewModel: ObservableObject {
    @Published var results: [MKMapItem] = []

    func search(for query: String, region: MKCoordinateRegion? = nil) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        
        if let region = region {
            request.region = region
        }

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            if let items = response?.mapItems {
                DispatchQueue.main.async {
                    self?.results = items
                }
            }
        }
    }
}

