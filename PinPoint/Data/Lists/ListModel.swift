//
//  ListModel.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-23.
//

import Foundation


struct PlaceListModel: Identifiable, Codable {
    let id: String
    let name: String
    let ownerId: String
    let isShared: Bool
    let createdAt: Date
}
