//
//  FirestoreService.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-11.
//
import FirebaseFirestore

final class FirestoreService {
    static let shared = FirestoreService()
    private let db = Firestore.firestore()
}
