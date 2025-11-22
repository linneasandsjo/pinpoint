//
//  GooglePlacesService.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-15.
//

import Foundation
import CoreLocation

class GooglePlacesREST {
    static let shared = GooglePlacesREST()
    private init() {}
    
    // Din API-nyckel (lägg den i Secrets/Config senare)
    private let apiKey = Bundle.main.googleAPIKey
    
    /// Tar namn + koordinater → returnerar Google PlaceID
    func getPlaceID(for name: String, near coordinate: CLLocationCoordinate2D) async throws -> String? {
        
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name
        
        let urlString =
        "https://maps.googleapis.com/maps/api/place/findplacefromtext/json" +
        "?input=\(encodedName)" +
        "&inputtype=textquery" +
        "&locationbias=point:\(coordinate.latitude),\(coordinate.longitude)" +
        "&fields=place_id" +
        "&key=\(apiKey)"
        
        print("🌐 [REST] FindPlace URL:", urlString)
        
        guard let url = URL(string: urlString) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(FindPlaceResponse.self, from: data)
        
        return response.candidates.first?.place_id
    }
}
    
    struct FindPlaceResponse: Codable {
        let candidates: [FindPlaceCandidate]
    }

    struct FindPlaceCandidate: Codable {
        let place_id: String
    }
