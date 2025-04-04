// //
// //  AuthenticationExample.swift
// //  Soup
// //
// //  Created by Максим Алексеев on 02.03.2025.
// //

// import SwiftUI
// import FirebaseAuth

// // Example of a login view using the auth service
// struct LoginView: View {
//     @Environment(\.dependencies) private var dependencies
    
//     @State private var email: String = ""
//     @State private var password: String = ""
//     @State private var isLoading: Bool = false
//     @State private var errorMessage: String? = nil
    
//     var body: some View {
//         VStack(spacing: 20) {
//             Text("Login")
//                 .font(.largeTitle)
//                 .fontWeight(.bold)
            
//             TextField("Email", text: $email)
//                 .textFieldStyle(RoundedBorderTextFieldStyle())
//                 .keyboardType(.emailAddress)
//                 .autocorrectionDisabled(true)
//                 .textInputAutocapitalization(.never)
            
//             SecureField("Password", text: $password)
//                 .textFieldStyle(RoundedBorderTextFieldStyle())
            
//             if let errorMessage = errorMessage {
//                 Text(errorMessage)
//                     .foregroundColor(.red)
//                     .font(.caption)
//             }
            
//             Button(action: login) {
//                 if isLoading {
//                     ProgressView()
//                 } else {
//                     Text("Sign In")
//                         .fontWeight(.semibold)
//                         .frame(maxWidth: .infinity)
//                 }
//             }
//             .padding()
//             .background(Color.blue)
//             .foregroundColor(.white)
//             .cornerRadius(8)
//             .disabled(isLoading)
            
//             Button(action: register) {
//                 Text("Register")
//                     .fontWeight(.medium)
//             }
//             .disabled(isLoading)
//         }
//         .padding()
//     }
    
//     private func login() {
//         isLoading = true
//         errorMessage = nil
        
//         dependencies.authService.signIn(emailAddress: email, password: password) { result in
//             isLoading = false
            
//             switch result {
//             case .success:
//                 // Successfully logged in - navigation will happen through state observation
//                 break
//             case .failure(let error):
//                 errorMessage = error.localizedDescription
//             }
//         }
//     }
    
//     private func register() {
//         isLoading = true
//         errorMessage = nil
        
//         dependencies.authService.signUp(emailAddress: email, password: password) { result in
//             isLoading = false
            
//             switch result {
//             case .success:
//                 // Successfully registered
//                 break
//             case .failure(let error):
//                 errorMessage = error.localizedDescription
//             }
//         }
//     }
// }

// // Main app component that handles authentication state
// struct AuthenticatedApp: View {
//     @Environment(\.dependencies) private var dependencies
//     @State private var isAuthenticated: Bool = false
    
//     var body: some View {
//         Group {
//             if isAuthenticated {
//                 MainAppView()
//             } else {
//                 LoginView()
//             }
//         }
//         .onChange(of: dependencies.authService.currentUser) { oldValue, newValue in
//             isAuthenticated = newValue != nil
//         }
//         .onAppear {
//             // Set initial state
//             isAuthenticated = dependencies.authService.currentUser != nil
//         }
//     }
// }

// // Main content after successful authentication
// struct MainAppView: View {
//     @Environment(\.dependencies) private var dependencies
    
//     var body: some View {
//         VStack {
//             Text("Welcome, you are logged in!")
//                 .font(.title)
            
//             Button("Sign Out") {
//                 let result = dependencies.authService.signOut()
//                 if case let .failure(error) = result {
//                     print("Sign out error: \(error.localizedDescription)")
//                 }
//             }
//             .padding()
//             .background(Color.red)
//             .foregroundColor(.white)
//             .cornerRadius(8)
//         }
//     }
// }

// // Adding the dependencies to the environment
// extension EnvironmentValues {
//     var dependencies: DependencyContainer {
//         get { self[DependencyContainerKey.self] }
//         set { self[DependencyContainerKey.self] = newValue }
//     }
// }

// // Environment key for the dependency container
// private struct DependencyContainerKey: EnvironmentKey {
//     static let defaultValue = DependencyContainer(authService: MockAuthService())
// }

// // Example of setting up the app with the auth service
// @main
// struct ExampleApp: App {
//     // Create the auth service
//     @State private var dependencies = DependencyContainer(authService: FirebaseAuthService())
    
//     var body: some Scene {
//         WindowGroup {
//             AuthenticatedApp()
//                 .environment(\.dependencies, dependencies)
//         }
//     }
// }

// // Example of using the service in a view model
// @Observable
// class ProfileViewModel {
//     private let authService: AuthServiceProtocol
    
//     var isLoggedIn: Bool = false
//     var userEmail: String?
    
//     init(authService: AuthServiceProtocol) {
//         self.authService = authService
//         updateUserState()
        
//         // Setup observation (would use NotificationCenter or other methods in real app)
//         #if DEBUG
//         // In a real app, you'd set up some observation mechanism
//         // This is simplified for example purposes
//         Task { @MainActor in
//             while true {
//                 try await Task.sleep(for: .seconds(1))
//                 updateUserState()
//             }
//         }
//         #endif
//     }
    
//     private func updateUserState() {
//         let user = authService.currentUser
//         isLoggedIn = user != nil
//         userEmail = user?.email
//     }
    
//     func signOut() {
//         let result = authService.signOut()
//         if case let .failure(error) = result {
//             // Handle sign out error
//             print("Error signing out: \(error.localizedDescription)")
//         }
//         updateUserState()
//     }
// } 