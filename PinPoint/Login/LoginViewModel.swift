//
//  LoginViewModel.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-11.
//

import SwiftUI
import FirebaseAuth

@MainActor
class LoginViewModel: ObservableObject {

    // Input
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""

    // UI state
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let userService = UserService()

    // MARK: - Login
    func login() {
        isLoading = true
        errorMessage = nil

        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            self.isLoading = false
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
        }
    }

    // MARK: - Signup
    func signUp() {
        isLoading = true
        errorMessage = nil

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            self.isLoading = false

            if let error = error {
                print("Firebase signup error:", error) //här
                self.errorMessage = error.localizedDescription
                return
            }

            guard let uid = result?.user.uid else { return }
            print("✅ Created user with uid:", uid)

            let user = UserModel(
                id: uid,
                username: self.username,
                email: self.email,
                createdAt: Date()
            )

            self.userService.createUser(user)
        }
    }
}
