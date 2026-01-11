//
//  SavedByFriendsButton.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-11.
//
import SwiftUI

struct SavedByFriendsButton: View {
    let isSavedByFriends: Bool;
    
    var body : some View{
        if isSavedByFriends {
            Label("Friends have saved this place", systemImage: "person.2.fill")
                .foregroundColor(.blue)
                .font(.subheadline)
        } else {
            Label("No friends include this place in their list", systemImage: "person.2")
                .foregroundColor(.blue)
                .font(.subheadline)
        }
    }
}
