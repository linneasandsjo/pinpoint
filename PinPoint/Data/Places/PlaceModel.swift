//
//  PlaceModel.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-11.
//
import Foundation

struct PlaceModel: Identifiable, Codable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    let createdAt: Date
    let createdBy: String
}
