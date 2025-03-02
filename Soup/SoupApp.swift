//
//  SoupApp.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}


@main
struct SoupApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            WithTabBar { tab in
                switch tab {
                case .map:
                    MapView()
                case .feelings:
                    MapView()
                case .countdown:
                    CountdownView()
                case .partner:
                    CountdownView()
                }
            }
        }
    }
}
