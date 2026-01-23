//
//  ListService.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class ListService {

    static let shared = ListService()
    private init() {}

    private let db = Firestore.firestore()

    // MARK: - Create list

    func createList(name: String, isShared: Bool = false) async throws {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "AuthError", code: 401)
        }

        let listId = UUID().uuidString

        let listData: [String: Any] = [
            "id": listId,
            "name": name,
            "ownerId": userId,
            "isShared": isShared,
            "createdAt": Timestamp(date: Date())
        ]

        try await db.collection("lists")
            .document(listId)
            .setData(listData)
    }
    
    func fetchListsForCurrentUser() async throws -> [PlaceListModel] {
        guard let userId = Auth.auth().currentUser?.uid else {
            throw NSError(domain: "AuthError", code: 401)
        }

        let snapshot = try await db.collection("lists")
            .whereField("ownerId", isEqualTo: userId)
            .getDocuments()

        return snapshot.documents.compactMap { doc in
            try? doc.data(as: PlaceListModel.self)
        }
    }
    
    func addPlace(
        _ place: PlaceModel,
        to listId: String
    ) async throws {

        let placeData: [String: Any] = [
            "id": place.id,
            "name": place.name,
            "latitude": place.latitude,
            "longitude": place.longitude,
            "createdAt": Timestamp(date: Date()),
            "createdBy": place.createdBy
        ]

        try await db.collection("lists")
            .document(listId)
            .collection("places")
            .document(place.id)
            .setData(placeData)
    }
}
