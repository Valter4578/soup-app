//
//  SoupApp.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import Combine
import FirebaseCore
import SwiftUI

@main
struct SoupApp: App {
    init() {
        FirebaseApp.configure()
        _firebaseAuthService = State(initialValue: FirebaseAuthService())
        _firebaseDatabaseService = State(initialValue: FirebaseDatabaseService())
        _themeManager = State(initialValue: ThemeManager(databaseService: firebaseDatabaseService!))
    }

    // MARK: - Dependencies

    @State private var firebaseAuthService: FirebaseAuthService?
    @State private var firebaseDatabaseService: FirebaseDatabaseService?
    @State private var themeManager: ThemeManager?
    
    // MARK: - Properties

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - State

    @State private var shouldShowAuth: Bool = true

    // MARK: - View body

    var body: some Scene {
        WindowGroup {
            ContentView(shouldShowAuth: firebaseAuthService?.user == nil)
                .environment(firebaseAuthService)
                .environment(firebaseDatabaseService)
                .environment(themeManager)
                .onAppear {
                    themeManager?.listenToFeelingChanges()
                }
        }
    }
}
