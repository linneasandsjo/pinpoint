//
//  ContentView.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-14.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FirstView()
                .tabItem { Label("Map", systemImage: "map") }

            //secondView
            Text("Saved List Coming Soon")
                .tabItem { Label("Saved", systemImage: "heart") }

            //thirdview
            Text("Friends Coming Soon")
                .tabItem { Label("Friends", systemImage: "person.2") }
        }
    }
}
