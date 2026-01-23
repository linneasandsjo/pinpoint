//
//  UserModel.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-11.
//
import Foundation

struct UserModel: Identifiable, Codable {
    let id: String
    let username: String
    let email: String
    let createdAt: Date
}
