//
//  AuthService.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-11.
//
import FirebaseAuth

class AuthService {
    static let shared = AuthService()

    var currentUserId: String? {
        Auth.auth().currentUser?.uid
    }

    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            completion(error)
        }
    }
}
