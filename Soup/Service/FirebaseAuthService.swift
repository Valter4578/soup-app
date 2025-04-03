//
//  FirebaseAuthService.swift
//  Soup
//
//  Created by Максим Алексеев  on 02.03.2025.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import SwiftUI
import Combine
import Observation

// Auth result type for handling authentication responses
enum AuthResult {
    case success
    case failure(Error)
}

// Authentication protocol that any auth service must implement
protocol AuthServiceProtocol {
    var currentUser: User? { get }
    
    func listenToAuthState()
    func signUp(emailAddress: String, password: String, completion: @escaping (AuthResult) -> Void)
    func signIn(emailAddress: String, password: String, completion: @escaping (AuthResult) -> Void)
    func signOut() -> AuthResult
}

/// Firebase implementation of the AuthServiceProtocol
@Observable
class FirebaseAuthService: AuthServiceProtocol {
    private(set) var user: User?
    
    // Protocol properties
    var currentUser: User? {
        return user
    }
        
    init() {
        listenToAuthState()
     }
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            self.user = user
            
        }
    }
    
    func signUp(
        emailAddress: String,
        password: String,
        completion: @escaping (AuthResult) -> Void
    ) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success)
        }
    }
    
    func signIn(
        emailAddress: String,
        password: String,
        completion: @escaping (AuthResult) -> Void
    ) {
        Auth.auth().signIn(withEmail: emailAddress, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success)
        }
    }
    
    func signOut() -> AuthResult {
        do {
            try Auth.auth().signOut()
            return .success
        } catch {
            return .failure(error)
        }
    }
}

//
//// Example of a mock auth service for testing
//@Observable
//class MockAuthService: AuthServiceProtocol {
//    private(set) var user: User?
//    
//    var currentUser: User? {
//        return user
//    }
//    
//    func listenToAuthState() {
//        // No-op in mock
//    }
//    
//    func signUp(emailAddress: String, password: String, completion: @escaping (AuthResult) -> Void) {
//        // Mock implementation
//        user = Auth.User() // This would be a mock user in a real implementation
//        completion(.success)
//    }
//    
//    func signIn(emailAddress: String, password: String, completion: @escaping (AuthResult) -> Void) {
//        // Mock implementation
//        user = Auth.User() // This would be a mock user in a real implementation
//        completion(.success)
//    }
//    
//    func signOut() -> AuthResult {
//        user = nil
//        return .success
//    }
//}
