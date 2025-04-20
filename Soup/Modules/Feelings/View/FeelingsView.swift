//
//  FeelingsView.swift
//  Soup
//
//  Created by Максим Алексеев  on 02.03.2025.
//

import SwiftUI
import BottomSheet // cause i fucking hate apple's bottom sheet

struct FeelingsView: View {
    // MARK: - Dependencies
    @Environment(FirebaseDatabaseService.self) private var firebaseDatabaseService
    @Environment(ThemeManager.self) private var themeManager
    
    @State private var viewModel = FeelingsViewModel()
    
    // MARK: - Properties
    @State private var isSheetPresented = true
    @State var bottomSheetPosition: BottomSheetPosition = .relative(0.4)
    
    // MARK: - View body
    var body: some View {
        NavigationStack {
            ZStack {
                themeManager.currentScheme.background
                    .ignoresSafeArea()
                
                VStack {
                    NavigationLink(destination: FeelingHistoryView()) {
                        HStack {
                            Image("history")
                            Spacer()
                        }
                        .padding(.leading, 16)
                    }
                    
                    ZStack {
                        Circle()
                            .frame(width: 200, height: 200)
                            .foregroundStyle(Color(hex: "#FFF").opacity(0.5))
                            .blur(radius: 85)
                        
                        Text(viewModel.partnersLastFeeling.emojiText)
                            .font(.system(size: 150))
                    }
                    .padding(.top, 100)
                    .padding(.horizontal, 105)
                    
                    Text(viewModel.feelingText())
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 105)
                    
                    Spacer()
                }
            }
            .onAppear {
                viewModel = FeelingsViewModel(databaseService: firebaseDatabaseService)
                viewModel.listenPartnersFeeling()
            }
            .bottomSheet(bottomSheetPosition: $bottomSheetPosition, switchablePositions: [
                .relative(0.4),
                .relativeTop(0.975)
            ]) {
                VStack(spacing: 20) {
                    Text("What about you?")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 20)
                    
                    FeelingsGridView(viewModel: viewModel, feelingSelected: { feeling in
                        viewModel.sendFeeling(feeling)
                    })
                }
            }
            .dragIndicatorColor(AppColors.Common.secondary)
            .enableContentDrag(true)
            .customBackground(
                Color.white
                    .cornerRadius(30)
                
            )
        }
    }
}

#Preview {
    FeelingsView()
        .environment(FirebaseDatabaseService())
        .environment(ThemeManager(databaseService: FirebaseDatabaseService()))
}
