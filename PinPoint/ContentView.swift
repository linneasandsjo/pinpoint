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
    var body: some View {
        MapView()
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
