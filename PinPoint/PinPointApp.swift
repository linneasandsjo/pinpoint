//
//  PinPointApp.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-14.
//

import SwiftUI
import GooglePlaces

@main
struct PinPointApp: App {
    
    init() {
        // Ladda Google Places API-nyckeln från ignore.plist
        GMSPlacesClient.provideAPIKey(Bundle.main.googleAPIKey)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
