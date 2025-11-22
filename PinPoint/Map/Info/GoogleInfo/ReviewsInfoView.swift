//
//  ReviewsInfoView.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-20.
//

import SwiftUI
import GooglePlaces

struct ReviewsInfoView: View {
    let rating: Float
    
    var body: some View {
        
        if rating > 0 {
            HStack {
                Text("\(rating, specifier: "%.1f")")
                Image(systemName: "star.fill").foregroundColor(.yellow)
                Text("(Source: Google)").foregroundColor(.gray).font(.caption)
            }
        }
        else {
            HStack {
                Image(systemName: "star.fill")
                Text("No rating available")
            }
        }
    }
}

