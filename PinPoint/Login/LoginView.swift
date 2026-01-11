//
//  LoginView.swift
//  PinPoint
//
//  Created by Linnea on 2026-01-11.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var vm = LoginViewModel()
    @State private var isSignup = false

    var body: some View {
        VStack(spacing: 16) {

            Text(isSignup ? "Create account" : "Login")
                .font(.largeTitle)
                .bold()

            if isSignup {
                TextField("Username", text: $vm.username)
                    .textFieldStyle(.roundedBorder)
            }

            TextField("Email", text: $vm.email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Password", text: $vm.password)
                .textFieldStyle(.roundedBorder)

            if let error = vm.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button {
                isSignup ? vm.signUp() : vm.login()
            } label: {
                if vm.isLoading {
                    ProgressView()
                } else {
                    Text(isSignup ? "Sign up" : "Login")
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.isLoading)

            Button {
                isSignup.toggle()
            } label: {
                Text(isSignup
                     ? "Already have an account? Login"
                     : "No account? Sign up")
                    .font(.footnote)
            }
        }
        .padding()
    }
}
