//
//  BorderedTextView.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import SwiftUI

/// Used for titles in the app
struct BorderedTextView: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .font(.system(size: 16, weight: .bold))
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .overlay {
                Capsule()
                    .strokeBorder(.white, lineWidth: 2)
            }
    }
}

#Preview {
    ZStack {
        AppColors.Common.primary
        BorderedTextView(text: "Next meeting in")
    }
        
}
