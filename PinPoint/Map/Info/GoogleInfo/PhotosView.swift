//
//  PhotosView.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-20.
//

import SwiftUI
import GooglePlaces

struct PhotosView: View {
    
    let photos: [UIImage]

    var body: some View {
        let screenWidth = UIScreen.main.bounds.width
                // Justerar för padding i PlaceInfoBaseView (16 + 16)
                let adjustedWidth = screenWidth - 32 - 8
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(photos.indices, id: \.self) { index in
                    Image(uiImage: photos[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: adjustedWidth, height: 260)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 4)
                }
            }
        }
    }
}
