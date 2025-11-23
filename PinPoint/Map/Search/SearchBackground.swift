//
//  SearchBackground.swift
//  PinPoint
//
//  Created by Linnea on 2025-11-23.
//

import SwiftUI

struct SearchBackground: View {
    var height: CGFloat

    var body: some View {
        Color(.systemGray6)
            .opacity(0.98)
            .frame(height: height * 0.80)
            .edgesIgnoringSafeArea(.top)
    }
}
