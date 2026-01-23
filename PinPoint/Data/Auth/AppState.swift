//
//  AppState.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-11.
//
import FirebaseAuth

class AppState: ObservableObject {
    @Published var user: UserModel?
    @Published var isLoggedIn = false

    init() {
        Auth.auth().addStateDidChangeListener { _, user in
            if let user = user {
                self.isLoggedIn = true
                UserService().fetchUser(userId: user.uid) {
                    self.user = $0
                }
            } else {
                self.isLoggedIn = false
                self.user = nil
            }
        }
    }
}
