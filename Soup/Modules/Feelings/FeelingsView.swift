//
//  FeelingsView.swift
//  Soup
//
//  Created by Максим Алексеев  on 02.03.2025.
//

import SwiftUI

struct FeelingsView: View {
    // MARK: - Dependencies
    @Environment(FirebaseDatabaseService.self) private var firebaseDatabaseService
    @Environment(ThemeManager.self) private var themeManager
    
    @State private var viewModel = FeelingsViewModel()
    
    // MARK: - Properties
    @State private var isSheetPresented = true
    
    // MARK: - View body
    var body: some View {
        ZStack {
            themeManager.currentScheme.background
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    Circle()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(Color(hex: "#FFF").opacity(0.5))
                        .blur(radius: 85)
                    
                    Text(viewModel.partnersLastFeeling.emojiText)
                        .font(.system(size: 150))
                }
                .padding(.top, 100)
                
                Text(viewModel.feelingText())
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding(.horizontal, 105)
        }
        .onAppear {
            viewModel = FeelingsViewModel(databaseService: firebaseDatabaseService)
            viewModel.listenPartnersFeeling()
        }
        .sheet(isPresented: $isSheetPresented) {
            VStack(spacing: 20) {
                Text("What about you?")
                    .font(.system(size: 22, weight: .bold))
                    .padding(.top, 20)
                
                FeelingsGridView(viewModel: viewModel, feelingSelected: { feeling in
                    viewModel.sendFeeling(feeling)
                })
                    .presentationDetents([.fraction(0.42), .large])
                    .presentationCornerRadius(50)
                    .presentationBackgroundInteraction(.enabled)
            }
            .zIndex(99)
        }
    }
}

#Preview {
    FeelingsView()
}
