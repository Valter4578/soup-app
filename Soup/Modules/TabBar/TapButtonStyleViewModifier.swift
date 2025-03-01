//
//  TapButtonStyleViewModifier.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import SwiftUI

struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
    }
}

extension View {
    func withTabButtonStyle() -> some View {
        buttonStyle(TabButtonStyle())
    }
}
