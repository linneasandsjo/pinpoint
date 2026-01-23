//
//  UserService.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-11.
//
import FirebaseFirestore

class UserService {
    private let db = Firestore.firestore()

    func createUser(_ user: UserModel) {
        try? db.collection("users")
            .document(user.id)
            .setData(from: user)
    }

    func fetchUser(userId: String, completion: @escaping (UserModel?) -> Void) {
        db.collection("users").document(userId).getDocument { snapshot, _ in
            completion(try? snapshot?.data(as: UserModel.self))
        }
    }
}
