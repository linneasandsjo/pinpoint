//
//  PinPointApp.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-14.
//

import SwiftUI
import GooglePlaces
import Firebase

@main
struct PinPointApp: App {
    @StateObject var appState = AppState()

    
    init() {
        FirebaseApp.configure()
        // Ladda Google Places API-nyckeln från ignore.plist
        GMSPlacesClient.provideAPIKey(Bundle.main.googleAPIKey)
    }
    
    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}
