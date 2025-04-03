//
//  ContentView.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import SwiftUI

struct ContentView: View {
    var shouldShowAuth: Bool
    var body: some View {
        if shouldShowAuth {
            AuthView()
        } else {
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

//#Preview {
//    ContentView(shouldShowAuth: Binding(get: {
//        return true
//    }, set: { _ in
//            
//    }))
//}
