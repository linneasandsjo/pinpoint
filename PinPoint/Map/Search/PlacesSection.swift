//
//  PlacesSection.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-26.
//  Sökresultat/ plats sektionen
import SwiftUI
import MapKit

struct PlacesSection: View {
    var query: String
    var results: [MKMapItem]
    var onSelect: (MKMapItem) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Places")
                .foregroundColor(.gray)
                .font(.headline)
                .padding(.leading)
            
            ZStack {
                if query.isEmpty {
                    Text("Start typing to search for places")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .padding()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            ForEach(results, id: \.self) { item in
                                Button(action: { onSelect(item) }) {
                                    Text(item.name ?? "Unknown")
                                        .foregroundColor(.black)
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                Divider()
                            }
                        }
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.35)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal)
        }
    }
}
