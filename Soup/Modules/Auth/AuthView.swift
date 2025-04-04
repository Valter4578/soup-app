//
//  AuthView.swift
//  Soup
//
//  Created by Максим Алексеев  on 03.03.2025.
//

import SwiftUI

struct AuthView: View {
    // MARK: - Dependencies
    @Environment(FirebaseAuthService.self) private var authService: FirebaseAuthService?
    @State private var viewModel = AuthViewModel()
    
    // MARK: - State
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isLoginMode = true

    // MARK: - View
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Logo or app name
                Text("Soup")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 30)

                // Email field
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                // Password field
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                // Confirm password field (only in sign up mode)
                if !isLoginMode {
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }

                // Login/Sign Up button
                Button(action: {
                    handleAuthentication()
                }) {
                    Text(isLoginMode ? "Log In" : "Sign Up")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }

                // Toggle between login and signup
                Button(action: {
                    isLoginMode.toggle()
                    // Clear confirm password when switching to login mode
                    if isLoginMode {
                        confirmPassword = ""
                    }
                }) {
                    Text(isLoginMode ? "Don't have an account? Sign Up" : "Already have an account? Log In")
                        .foregroundColor(.blue)
                        .padding(.top, 10)
                }

                Spacer()
            }
            .padding(.top, 50)
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel = AuthViewModel(authService: authService)
        }
    }

    private func handleAuthentication() {
        // Here you would implement your authentication logic
        if isLoginMode {
            print("Attempting to log in with email: \(email)")
            viewModel.login(email: email, password: password)
        } else {
            // Handle sign up
            if password == confirmPassword {
                print("Attempting to sign up with email: \(email)")
                viewModel.signUp(email: email, password: password)
            } else {
                print("Passwords don't match")
            }
        }
    }
}

#Preview {
    AuthView()
}
