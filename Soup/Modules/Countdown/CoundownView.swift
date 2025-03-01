//
//  CoundownView.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import SwiftUI
import UIKit

struct CoundownView: View {
    // MARK: - View body
    var body: some View {
        ZStack {
            AnimatedMeshGradient()
                .ignoresSafeArea(.all, edges: .all)
                .blur(radius: 10)
            
            VStack(spacing: .zero) {
                BorderedTextView(text: "Next meeting in")
                    .padding(.bottom, 40)
                Text("00:00:00")
                    .foregroundStyle(.white)
                    .font(Font.custom("Borsok", size: 60))
                    .padding(.bottom, 74)
                
                ButtonView(withStroke: true ,action: {
                    print("Button tapped")
                }, label: "We've met")
            }
        }
    }
    
    // MARK: - Subviews
    
}

#Preview {
    CoundownView()
}
