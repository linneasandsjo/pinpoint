//
//  InspirationSection.swift
//  PinPoint
//
//  Created by Linnea on 2025-09-26.
//  Inspirationds-delen

import SwiftUI

struct InspirationSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Inspiration")
                .foregroundColor(.gray)
                .font(.headline)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(0..<10) { i in
                        FriendItemView()
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal)
        }
    }
}
