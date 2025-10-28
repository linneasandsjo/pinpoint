//
//  FriendItemView.swift
//  PinPoint
//
//  Created by Linnea on 2025-10-07.
// En placeholder för friends bild/ listas bild och dess namn

import SwiftUI

struct FriendItemView: View {
 //   let friend: FriendModel senare för att hantera logiken

    var body: some View {
        VStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 60, height: 60)
            
            Text("Friend X")
                .font(.caption)
        }
    }
}
