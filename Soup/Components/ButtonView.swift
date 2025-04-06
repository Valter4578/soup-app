//
//  ButtonView.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import SwiftUI

struct ButtonView: View {
    @Environment(ThemeManager.self) private var themeManager

    var withStroke: Bool = false
    var action: () -> Void
    var label: String
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .padding(.vertical, 15)
                .padding(.horizontal, 30)
                .background(
                    Capsule()
                        .fill(themeManager.currentScheme.primary)
                        .strokeBorder(.white, lineWidth: withStroke ? 0.5 : 0)
                )
        }
    }
}

#Preview {
    ZStack {
        
        ButtonView(withStroke: true, action: {
            print("Button tapped")
        }, label: "We've met")
        .ignoresSafeArea()
    }
}
