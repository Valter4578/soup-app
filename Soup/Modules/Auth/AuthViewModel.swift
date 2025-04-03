//
//  AuthViewModel.swift
//  Soup
//
//  Created by Максим Алексеев  on 03.04.2025.
//

import Foundation
import SwiftUI

@Observable
final class AuthViewModel {
    // MARK: - Dependencies
    private var authService: AuthServiceProtocol?
    
    // MARK: - Init
    init(authService: AuthServiceProtocol? = nil) {
        self.authService = authService
    }
    
    func login(email: String, password: String) {
        authService?.signIn(emailAddress: email, password: password, completion: { result in
            switch result {
            case .success:
                print("Successfully logged in with user: \(self.authService?.currentUser?.email)")
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func signUp(email: String, password: String) {
        authService?.signUp(emailAddress: email, password: password, completion: { result in
            switch result {
            case .success:
                print("Successfully signeup with user: \(self.authService?.currentUser?.email)")

            case .failure(let error):
                print(error)
            }
        })
    }
}
