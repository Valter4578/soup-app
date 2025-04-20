//
//  FeelingHistoryView.swift
//  Soup
//
//  Created by Максим Алексеев  on 20.04.2025.
//

import SwiftUI

struct FeelingHistoryView: View {
    @State private var viewModel: FeelingHistoryViewModel
    @Environment(FirebaseDatabaseService.self) var databaseService
    
    // MARK: - Init
    init() {
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 22, weight: .bold)
        ]
        
        _viewModel = State(initialValue: FeelingHistoryViewModel())
   }
    
    // MARK: - View body
    var body: some View {
        NavigationStack {
            ZStack {
                Feeling.happy.colorScheme.primary
                    .ignoresSafeArea()
//                
                LazyVStack {
                    ForEach(viewModel.feelings) { response in
                        FeelingHistoryCellView(feeling: response.feeling)
                    }
                }
            }
            .navigationTitle("Emotion history")
            .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Image("back")
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Image("history")
                        }
                    }
        }
        .onAppear {
            viewModel = FeelingHistoryViewModel(databaseService: databaseService)
            viewModel.getFeelings()
            print(viewModel.feelings)
        }
    }
}

#Preview {
    FeelingHistoryView()
}
