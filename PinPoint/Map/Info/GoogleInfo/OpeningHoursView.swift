//
//  OpeningHoursView.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-19.
//

import SwiftUI
import GooglePlaces

struct OpeningHoursView: View {
    let hours: GMSOpeningHours
    
    @State private var showAll = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            // MARK: - Today's Hours Row
            if let todayLine = hours.todayText() {
                HStack {
                    Image(systemName: "clock")
                    
                    Text(todayLine)
                        .foregroundColor(.primary)
                    
                    // Toggle button
                    Button(action: {
                        withAnimation(.easeInOut) {
                            showAll.toggle()
                        }
                    }) {
                        Image(systemName: showAll ? "arrowtriangle.up.fill"
                                                  : "arrowtriangle.down.fill")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    
                    .font(.caption)
                }
            }
            
            // MARK: - Expanded list
            if showAll, let list = hours.weekdayText {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(list, id: \.self) { dayLine in
                        Text(dayLine)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .transition(.opacity.combined(with: .opacity))
            }
        }
        .padding(.vertical, 4)
    }
}

