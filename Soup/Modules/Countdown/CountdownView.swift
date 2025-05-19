//
//  CountdownView.swift
//  Soup
//
//  Created by Максим Алексеев  on 01.03.2025.
//

import SwiftUI

struct CountdownView: View {
    // MARK: - Dependencies
    @Environment(FirebaseDatabaseService.self) var databaseService
    @Environment(ThemeManager.self) var themeManager
    @State private var viewModel: CountdownViewModel?
    
    // MARK: - Init
    
    init() {
        _viewModel = State(initialValue: CountdownViewModel(dbService: nil))
    }
    
    // MARK: - View body
    var body: some View {
        NavigationStack {
            ZStack {
                AnimatedMeshGradient()
                    .ignoresSafeArea(.all, edges: .all)
                    .blur(radius: 10)
                
                Group {
                    switch viewModel?.state {
                    case .empty:
                        emptyStateView()
                    case .running:
                        runningStateView()
                    case nil:
                        emptyStateView()
                    }

                }
            }
            .overlay {
                ConfettiView()
            }
            .onAppear {
                viewModel = CountdownViewModel(dbService: databaseService)
                
                viewModel?.onAppear()
//                viewModel?.startTimer()
                
            }
        }
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private func emptyStateView() -> some View {
        VStack(spacing: .zero) {
            Text("Your\nfuture\nmeeting".capitalized)
                .foregroundStyle(.white)
                .font(Font.custom("Borsok", size: 60))
                .padding(.bottom, 74)
            
            NavigationLink {
                SetCountdownView(viewModel: viewModel!)
            } label: {
                Text("Set countdown")
                    .foregroundStyle(themeManager.currentScheme.primary)
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 100))
            }

        }
    }
    
    @ViewBuilder
    private func runningStateView() -> some View {
        
        VStack(spacing: .zero) {
            Text("Next meeting in")
                .foregroundStyle(.white)
                .font(.system(size: 16, weight: .bold))
                .padding(.vertical, 8)
                .padding(.horizontal, 20)                .padding(.bottom, 40)
            Text(viewModel?.formattedTime ?? "")
                .foregroundStyle(.white)
                .font(Font.custom("Borsok", size: 60))
                .lineSpacing(16)
                .multilineTextAlignment(.center)
                .padding(.bottom, 74)
            
            ButtonView(withStroke: true ,action: {
                viewModel?.stopTimer()
            }, text: "We've met")
        }
    }
}

#Preview {
    CountdownView()
        .environment(FirebaseDatabaseService())
        .environment(ThemeManager(databaseService: FirebaseDatabaseService()))
}
