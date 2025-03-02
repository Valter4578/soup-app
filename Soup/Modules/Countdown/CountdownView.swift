//
//  CountdownView.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import SwiftUI

struct CountdownView: View {
    // MARK: - Dependencies
    @State private var viewModel = CountdownViewModel()
    
    // MARK: - View body
    var body: some View {
        ZStack {
            AnimatedMeshGradient()
                .ignoresSafeArea(.all, edges: .all)
                .blur(radius: 10)
            
            VStack(spacing: .zero) {
                BorderedTextView(text: "Next meeting in")
                    .padding(.bottom, 40)
                Text(viewModel.formattedTime)
                    .foregroundStyle(.white)
                    .font(Font.custom("Borsok", size: 60))
                    .padding(.bottom, 74)
                
                ButtonView(withStroke: true ,action: {
                    viewModel.stopTimer()
                }, label: "We've met")
            }
        }
        .overlay {
            ConfettiView()
        }
        .onAppear {
            viewModel.startTimer()
        }
    }
    
    // MARK: - Subviews
    
}

#Preview {
    CountdownView()
}
